import 'package:ble_scanner/domain/use_cases/connect_to_device_use_case.dart';
import 'package:ble_scanner/domain/use_cases/discover_services_use_case.dart';
import 'package:ble_scanner/domain/use_cases/scan_for_devices_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'ble_state.dart';

class BLECubit extends Cubit<BLEState> {
  final ScanForDevicesUseCase scanForDevicesUseCase;
  final ConnectToDeviceUseCase connectToDeviceUseCase;
  final DiscoverServicesUseCase discoverServicesUseCase;

  BLECubit({
    required this.scanForDevicesUseCase,
    required this.connectToDeviceUseCase,
    required this.discoverServicesUseCase,
  }) : super(BLEState.initial());

  Future<void> scanForDevices() async {
    emit(state.copyWith(isLoading: true));
    try {
      final devices = await scanForDevicesUseCase.execute();
      emit(state.copyWith(isLoading: false, devices: devices));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> connectToDevice(BluetoothDevice device) async {
    emit(state.copyWith(isLoading: true));
    try {
      await connectToDeviceUseCase.execute(device);
      emit(state.copyWith(isLoading: false, device: device));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> discoverServices(BluetoothDevice device) async {
    emit(state.copyWith(isLoading: true));
    try {
      final services = await discoverServicesUseCase.execute(device);
      emit(state.copyWith(isLoading: false, services: services));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
