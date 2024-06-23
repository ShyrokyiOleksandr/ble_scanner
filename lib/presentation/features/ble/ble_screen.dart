import 'package:ble_scanner/presentation/features/ble/bloc/ble_cubit.dart';
import 'package:ble_scanner/presentation/features/ble/bloc/ble_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class BLEScreen extends StatelessWidget {
  late final _screenBloc = GetIt.I<BLECubit>();

  BLEScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter BLE'),
      ),
      body: BlocBuilder<BLECubit, BLEState>(
        bloc: _screenBloc,
        builder: (context, state) {
          if (state is BLEInitial) {
            return const Center(child: Text('Press the button to scan for devices'));
          } else if (state is BLELoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is BLELoaded) {
            return ListView.builder(
              itemCount: state.devices.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.devices[index].name),
                  subtitle: Text(state.devices[index].id),
                  onTap: () {
                    context.read<BLECubit>().connectToDeviceEvent(state.devices[index]);
                  },
                );
              },
            );
          } else if (state is BLEConnected) {
            context.read<BLECubit>().discoverServicesEvent(state.device);
            return Center(child: Text('Connected to ${state.device.name}'));
          } else if (state is BLEServicesDiscovered) {
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
          } else if (state is BLEError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
