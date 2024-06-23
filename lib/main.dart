import 'package:ble_scanner/app_service_locator.dart';
import 'package:ble_scanner/presentation/app/ble_app.dart';
import 'package:flutter/material.dart';

void main() {
  AppServiceLocator.setup();

  runApp(const BleApp());
}
