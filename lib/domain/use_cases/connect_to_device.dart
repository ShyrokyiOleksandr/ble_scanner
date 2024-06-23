import 'package:ble_scanner/domain/repositories/ble_repository.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConnectToDevice {
  final BLERepository repository;

  ConnectToDevice(this.repository);

  Future<void> call(BluetoothDevice device) async {
    await repository.connectToDevice(device);
  }
}
