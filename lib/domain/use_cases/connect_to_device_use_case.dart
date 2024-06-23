import 'package:ble_scanner/domain/repositories/ble_repository.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConnectToDeviceUseCase {
  final BLERepository repository;

  ConnectToDeviceUseCase(this.repository);

  Future<void> execute(BluetoothDevice device) async {
    await repository.connectToDevice(device);
  }
}
