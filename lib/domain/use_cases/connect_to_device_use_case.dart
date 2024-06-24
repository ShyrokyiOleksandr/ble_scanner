import 'package:ble_scanner/domain/repositories/ble_repository.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ConnectToDeviceUseCase {
  final BLERepository repository;

  ConnectToDeviceUseCase(this.repository);

  Stream<BluetoothDeviceState> execute(BluetoothDevice device) {
    return repository.connectToDevice(device);
  }
}
