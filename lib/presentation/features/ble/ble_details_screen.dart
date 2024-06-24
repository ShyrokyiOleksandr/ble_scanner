import 'dart:developer';

import 'package:ble_scanner/presentation/utils/bluetooth_service_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get_it/get_it.dart';

import 'bloc/ble_cubit.dart';
import 'bloc/ble_state.dart';

class BLEDetailsScreen extends StatefulWidget {
  final BluetoothDevice device;
  const BLEDetailsScreen({
    required this.device,
    Key? key,
  }) : super(key: key);

  @override
  State<BLEDetailsScreen> createState() => _BLEDetailsScreenState();
}

class _BLEDetailsScreenState extends State<BLEDetailsScreen> {
  static const _defaultMargin = 12.0;

  late final BLECubit _screenBloc = GetIt.I<BLECubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device ID: ${widget.device.id.id}'),
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
          log(state.toString());

          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.device == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Connect to device: ${widget.device.name}?"),
                  const SizedBox(height: _defaultMargin),
                  ElevatedButton(
                    onPressed: () => _connectToDevice(widget.device),
                    child: const Text("Connect"),
                  ),
                ],
              ),
            );
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Connected to device: ${widget.device.name}"),
                const SizedBox(height: _defaultMargin),
                const Text("Discover services?"),
                const SizedBox(height: _defaultMargin),
                if (state.services.isEmpty)
                  ElevatedButton(
                    onPressed: () => _discoverServices(widget.device),
                    child: const Text("Discover"),
                  ),
                const SizedBox(height: _defaultMargin),
                if (state.services.isNotEmpty)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: _defaultMargin),
                      child: ListView.separated(
                        itemCount: state.services.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              const SizedBox(height: _defaultMargin),
                              Text(
                                "Service ${index + 1}:",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              const SizedBox(height: _defaultMargin),
                              Text(state.services[index].prettyString()),
                              const SizedBox(height: _defaultMargin),
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(height: 1, color: Colors.grey);
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _connectToDevice(BluetoothDevice device) async {
    await _screenBloc.connectToDevice(device);
  }

  void _discoverServices(BluetoothDevice device) async {
    await _screenBloc.discoverServices(device);
  }
}
