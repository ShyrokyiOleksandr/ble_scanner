import 'package:flutter_blue/flutter_blue.dart';

abstract class BLERepository {
  Future<List<BluetoothDevice>> scanForDevices();
  Future<void> connectToDevice(BluetoothDevice device);
  Future<List<BluetoothService>> discoverServices(BluetoothDevice device);
}
