import 'package:ble_scanner/domain/repositories/ble_repository.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DiscoverServices {
  final BLERepository repository;

  DiscoverServices(this.repository);

  Future<List<BluetoothService>> call(BluetoothDevice device) async {
    return await repository.discoverServices(device);
  }
}
