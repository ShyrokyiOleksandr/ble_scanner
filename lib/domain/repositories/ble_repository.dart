import 'package:flutter_blue/flutter_blue.dart';

abstract class BLERepository {
  Stream<List<BluetoothDevice>> scanForDevices();
  Stream<BluetoothDeviceState> connectToDevice(BluetoothDevice device);
  Future<List<BluetoothService>> discoverServices(BluetoothDevice device);
}
