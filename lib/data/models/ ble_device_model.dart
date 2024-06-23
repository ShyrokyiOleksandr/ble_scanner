import 'package:ble_scanner/domain/entities/ble_device.dart';
import 'package:flutter_blue/flutter_blue.dart' show BluetoothDevice;

class BLEDeviceModel extends BLEDevice {
  BLEDeviceModel({required String id, required String name}) : super(id: id, name: name);

  factory BLEDeviceModel.fromBluetoothDevice(BluetoothDevice device) {
    return BLEDeviceModel(
      id: device.id.id,
      name: device.name,
    );
  }
}
