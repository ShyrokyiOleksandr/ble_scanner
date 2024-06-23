import 'package:ble_scanner/domain/entities/ble_device.dart';
import 'package:flutter_blue/flutter_blue.dart';

abstract class BLERepository {
  Future<List<BLEDevice>> scanForDevices();
  Future<void> connectToDevice(BluetoothDevice device);
  Future<List<BluetoothService>> discoverServices(BluetoothDevice device);
}
