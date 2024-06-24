import 'dart:async';
import 'dart:developer';

import 'package:flutter_blue/flutter_blue.dart';

abstract class BLERemoteDataSource {
  Stream<List<BluetoothDevice>> scanForDevices();
  Stream<BluetoothDeviceState> connectToDevice(BluetoothDevice device);
  Future<List<BluetoothService>> discoverServices(BluetoothDevice device);
}

class BLERemoteDataSourceImpl implements BLERemoteDataSource {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  @override
  Stream<List<BluetoothDevice>> scanForDevices() async* {
    log('Starting device scan...');

    // Start the scan
    _flutterBlue.startScan(timeout: const Duration(seconds: 4));
    log('Scan started.');

    // Create a stream controller to manage the scan results
    final StreamController<List<BluetoothDevice>> controller =
        StreamController<List<BluetoothDevice>>();

    // Listen to the scan results and add them to the controller
    _flutterBlue.scanResults.listen((results) {
      List<BluetoothDevice> devices = results.map((r) => r.device).toList();
      controller.add(devices);
    });
    log('Listening to scan results...');

    // Yield the controller's stream
    yield* controller.stream;

    // Stop the scan after the timeout
    await Future.delayed(const Duration(seconds: 4));
    _flutterBlue.stopScan();
    log('Scan stopped.');

    // Close the controller when done
    await controller.close();
    log('Stream controller closed.');
  }

  @override
  Stream<BluetoothDeviceState> connectToDevice(BluetoothDevice device) async* {
    log('Connecting to device ${device.name}...');

    final streamController = StreamController<BluetoothDeviceState>();

    device.state.listen((stateEvent) async {
      if (stateEvent == BluetoothDeviceState.disconnected) {
        await device.connect();
        log('Connected to device ${device.name}.');
      }

      streamController.add(stateEvent);
    });

    yield* streamController.stream;
  }

  @override
  Future<List<BluetoothService>> discoverServices(BluetoothDevice device) async {
    log('Discovering services for device ${device.name}...');

    List<BluetoothService> services = await device.discoverServices();

    log('Discovered ${services.length} services for device ${device.name}.');
    return services;
  }
}
