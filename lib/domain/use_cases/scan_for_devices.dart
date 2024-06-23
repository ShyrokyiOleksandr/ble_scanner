import 'package:ble_scanner/domain/entities/ble_device.dart';
import 'package:ble_scanner/domain/repositories/ble_repository.dart';

class ScanForDevices {
  final BLERepository repository;

  ScanForDevices(this.repository);

  Future<List<BLEDevice>> call() async {
    return await repository.scanForDevices();
  }
}
