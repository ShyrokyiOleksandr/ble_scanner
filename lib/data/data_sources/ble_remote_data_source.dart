import 'package:flutter_blue/flutter_blue.dart';

abstract class BLERemoteDataSource {
  Future<List<BluetoothDevice>> scanForDevices();
  Future<void> connectToDevice(BluetoothDevice device);
  Future<List<BluetoothService>> discoverServices(BluetoothDevice device);
}

class BLERemoteDataSourceImpl implements BLERemoteDataSource {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  @override
  Future<List<BluetoothDevice>> scanForDevices() async {
    List<BluetoothDevice> devices = [];
    _flutterBlue.startScan(timeout: const Duration(seconds: 4));
    await for (var scanResultList in _flutterBlue.scanResults) {
      for (ScanResult scanResult in scanResultList) {
        devices.add(scanResult.device);
      }
    }
    _flutterBlue.stopScan();
    return devices;
  }

  @override
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
  }

  @override
  Future<List<BluetoothService>> discoverServices(BluetoothDevice device) async {
    return await device.discoverServices();
  }
}
