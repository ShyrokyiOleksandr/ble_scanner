import 'package:ble_scanner/domain/entities/ble_device.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue/flutter_blue.dart';

abstract class BLEState extends Equatable {
  const BLEState();

  @override
  List<Object> get props => [];
}

class BLEInitial extends BLEState {}

class BLELoading extends BLEState {}

class BLELoaded extends BLEState {
  final List<BLEDevice> devices;

  const BLELoaded(this.devices);

  @override
  List<Object> get props => [devices];
}

class BLEConnected extends BLEState {
  final BluetoothDevice device;

  const BLEConnected(this.device);

  @override
  List<Object> get props => [device];
}

class BLEServicesDiscovered extends BLEState {
  final List<BluetoothService> services;

  const BLEServicesDiscovered(this.services);

  @override
  List<Object> get props => [services];
}

class BLEError extends BLEState {
  final String message;

  const BLEError(this.message);

  @override
  List<Object> get props => [message];
}
