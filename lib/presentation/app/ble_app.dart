import 'package:ble_scanner/presentation/features/ble/ble_screen.dart';
import 'package:flutter/material.dart';

class BleApp extends StatelessWidget {
  const BleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BLEScreen(),
    );
  }
}
