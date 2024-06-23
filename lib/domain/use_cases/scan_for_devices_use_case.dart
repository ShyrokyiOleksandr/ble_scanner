import 'package:ble_scanner/domain/repositories/ble_repository.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ScanForDevicesUseCase {
  final BLERepository repository;

  ScanForDevicesUseCase(this.repository);

  Future<List<BluetoothDevice>> execute() async {
    return await repository.scanForDevices();
  }
}
