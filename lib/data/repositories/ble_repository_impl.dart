import 'package:ble_scanner/data/data_sources/ble_remote_data_source.dart';
import 'package:ble_scanner/domain/repositories/ble_repository.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLERepositoryImpl implements BLERepository {
  final BLERemoteDataSource remoteDataSource;

  BLERepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<BluetoothDevice>> scanForDevices() async {
    return await remoteDataSource.scanForDevices();
  }

  @override
  Future<void> connectToDevice(BluetoothDevice device) async {
    await remoteDataSource.connectToDevice(device);
  }

  @override
  Future<List<BluetoothService>> discoverServices(BluetoothDevice device) async {
    return await remoteDataSource.discoverServices(device);
  }
}
