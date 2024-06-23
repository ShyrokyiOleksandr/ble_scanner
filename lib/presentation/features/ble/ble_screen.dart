import 'package:ble_scanner/presentation/features/ble/bloc/ble_cubit.dart';
import 'package:ble_scanner/presentation/features/ble/bloc/ble_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

class BLEScreen extends StatefulWidget {
  const BLEScreen({super.key});

  @override
  State<BLEScreen> createState() => _BLEScreenState();
}

class _BLEScreenState extends State<BLEScreen> {
  late final _screenBloc = GetIt.I<BLECubit>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await requestPermissions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter BLE'),
      ),
      body: BlocBuilder<BLECubit, BLEState>(
        bloc: _screenBloc,
        builder: (context, state) {
          if (state == BLEState.initial()) {
            return Center(
              child: Column(
                children: [
                  const Text('Press the button to scan for devices'),
                  const SizedBox(height: 8),
                  ElevatedButton(onPressed: _scan, child: const Text("Scan")),
                ],
              ),
            );
          } else if (state.isLoading == true) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.isLoading == false && state.devices.isNotEmpty) {
            return ListView.builder(
              itemCount: state.devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.devices[index].name),
                  subtitle: Text(state.devices[index].id.id),
                  onTap: () => _connectToDevice(state.devices[index]),
                );
              },
            );
          } else if (state.isLoading == false && state.device != null) {
            _discoverService(state.device!);
            return Center(child: Text('Connected to ${state.device?.name}'));
          } else if (state.isLoading == false && state.device != null) {
            return ListView.builder(
              itemCount: state.services.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Service: ${state.services[index].uuid.toString()}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.services[index].characteristics.map((c) {
                      return ListTile(
                        title: Text('Characteristic: ${c.uuid.toString()}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ElevatedButton(
                              child: const Text('Read'),
                              onPressed: () async {
                                var value = await c.read();
                                WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Value: $value')),
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                );
              },
            );
          } else if (state.isLoading == false && state.errorMessage != null) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }

  void _scan() async {
    await _screenBloc.scanForDevices();
  }

  void _connectToDevice(BluetoothDevice device) async {
    await _screenBloc.connectToDevice(device);
  }

  void _discoverService(BluetoothDevice device) async {
    await _screenBloc.discoverServices(device);
  }

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.location,
    ].request();

    if (statuses[Permission.bluetooth]!.isGranted &&
        statuses[Permission.bluetoothScan]!.isGranted &&
        statuses[Permission.location]!.isGranted) {
    } else {}
  }
}
