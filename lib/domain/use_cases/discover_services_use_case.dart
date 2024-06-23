import 'package:ble_scanner/domain/repositories/ble_repository.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DiscoverServicesUseCase {
  final BLERepository repository;

  DiscoverServicesUseCase(this.repository);

  Future<List<BluetoothService>> execute(BluetoothDevice device) async {
    return await repository.discoverServices(device);
  }
}
