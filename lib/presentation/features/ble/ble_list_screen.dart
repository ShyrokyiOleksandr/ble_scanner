import 'package:ble_scanner/presentation/features/ble/ble_details_screen.dart';
import 'package:ble_scanner/presentation/features/ble/widgets/device_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';

import 'bloc/ble_cubit.dart';
import 'bloc/ble_state.dart';

class BLEListScreen extends StatefulWidget {
  const BLEListScreen({Key? key}) : super(key: key);

  @override
  State<BLEListScreen> createState() => _BLEListScreenState();
}

class _BLEListScreenState extends State<BLEListScreen> {
  late final BLECubit _screenBloc = GetIt.I<BLECubit>();

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
      body: BlocConsumer<BLECubit, BLEState>(
        bloc: _screenBloc,
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage.toString()),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state == BLEState.initial()) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Press the button to scan for devices'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: _scan,
                    child: const Text("Scan"),
                  ),
                ],
              ),
            );
          }

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.devices.isNotEmpty) {
            return DeviceListWidget(
                devices: state.devices,
                onDeviceTap: (device) {
                  return Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => BLEDetailsScreen(device: device)),
                  );
                });
          }
          return const SizedBox();
        },
      ),
    );
  }

  void _scan() async {
    await _screenBloc.scanForDevices();
  }

  Future<void> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.bluetoothAdvertise,
      Permission.location,
    ].request();

    if (!statuses[Permission.bluetooth]!.isGranted ||
        !statuses[Permission.bluetoothScan]!.isGranted ||
        !statuses[Permission.location]!.isGranted) {
      // Handle permissions not granted
    }
  }
}
