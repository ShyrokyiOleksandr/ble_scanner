// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BLEState extends Equatable {
  final bool isLoading;
  final List<BluetoothDevice> devices;
  final BluetoothDevice? device;
  final List<BluetoothService> services;
  final String? errorMessage;

  const BLEState({
    required this.isLoading,
    required this.devices,
    required this.device,
    required this.services,
    required this.errorMessage,
  });

  factory BLEState.initial() {
    return const BLEState(
      isLoading: false,
      devices: [],
      device: null,
      services: [],
      errorMessage: null,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      isLoading,
      devices,
      device,
      services,
      errorMessage,
    ];
  }

  BLEState copyWith({
    bool? isLoading,
    List<BluetoothDevice>? devices,
    BluetoothDevice? device,
    List<BluetoothService>? services,
    String? errorMessage,
  }) {
    return BLEState(
      isLoading: isLoading ?? this.isLoading,
      devices: devices ?? this.devices,
      device: device ?? this.device,
      services: services ?? this.services,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
