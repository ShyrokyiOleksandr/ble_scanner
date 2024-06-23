import 'package:ble_scanner/data/models/%20ble_device_model.dart';
import 'package:flutter_blue/flutter_blue.dart';

abstract class BLERemoteDataSource {
  Future<List<BLEDeviceModel>> scanForDevices();
  Future<void> connectToDevice(BluetoothDevice device);
  Future<List<BluetoothService>> discoverServices(BluetoothDevice device);
}

class BLERemoteDataSourceImpl implements BLERemoteDataSource {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;

  @override
  Future<List<BLEDeviceModel>> scanForDevices() async {
    List<BLEDeviceModel> devices = [];
    _flutterBlue.startScan(timeout: const Duration(seconds: 4));
    await for (var result in _flutterBlue.scanResults) {
      for (ScanResult r in result) {
        devices.add(BLEDeviceModel.fromBluetoothDevice(r.device));
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
