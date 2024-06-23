import 'package:ble_scanner/domain/use_cases/connect_to_device.dart';
import 'package:ble_scanner/domain/use_cases/discover_services.dart';
import 'package:ble_scanner/domain/use_cases/scan_for_devices.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ble_state.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLECubit extends Cubit<BLEState> {
  final ScanForDevices scanForDevices;
  final ConnectToDevice connectToDevice;
  final DiscoverServices discoverServices;

  BLECubit({
    required this.scanForDevices,
    required this.connectToDevice,
    required this.discoverServices,
  }) : super(BLEInitial());

  Future<void> scanForDevicesEvent() async {
    emit(BLELoading());
    try {
      final devices = await scanForDevices();
      emit(BLELoaded(devices));
    } catch (e) {
      emit(BLEError(e.toString()));
    }
  }

  Future<void> connectToDeviceEvent(BluetoothDevice device) async {
    emit(BLELoading());
    try {
      await connectToDevice(device);
      emit(BLEConnected(device));
    } catch (e) {
      emit(BLEError(e.toString()));
    }
  }

  Future<void> discoverServicesEvent(BluetoothDevice device) async {
    emit(BLELoading());
    try {
      final services = await discoverServices(device);
      emit(BLEServicesDiscovered(services));
    } catch (e) {
      emit(BLEError(e.toString()));
    }
  }
}
