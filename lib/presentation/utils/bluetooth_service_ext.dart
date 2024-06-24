// Extend BluetoothService class to add a toString method
import 'package:flutter_blue/flutter_blue.dart';

// Extend BluetoothService class to add a prettyString method
extension BluetoothServicePrettyString on BluetoothService {
  String prettyString() {
    return 'BluetoothService {\n'
        '  uuid: ${uuid.toString()},\n'
        '  deviceId: ${deviceId.toString()},\n'
        '  isPrimary: $isPrimary,\n'
        '  characteristics: [\n${characteristics.map((c) => '    ${c.prettyString()}').join(',\n')}\n  ],\n'
        '  includedServices: [\n${includedServices.map((s) => '    ${s.prettyString()}').join(',\n')}\n  ]\n'
        '}';
  }
}

// Extend BluetoothCharacteristic class to add a prettyString method
extension BluetoothCharacteristicPrettyString on BluetoothCharacteristic {
  String prettyString() {
    return 'BluetoothCharacteristic {\n'
        '  uuid: ${uuid.toString()},\n'
        '  deviceId: ${deviceId.toString()},\n'
        '  serviceUuid: ${serviceUuid.toString()},\n'
        '  secondaryServiceUuid: ${secondaryServiceUuid?.toString()},\n'
        '  descriptors: [\n${descriptors.map((d) => '    ${d.prettyString()}').join(',\n')}\n  ]\n'
        '}';
  }
}

// Extend BluetoothDescriptor class to add a prettyString method
extension BluetoothDescriptorPrettyString on BluetoothDescriptor {
  String prettyString() {
    return 'BluetoothDescriptor {\n'
        '  uuid: ${uuid.toString()},\n'
        '  deviceId: ${deviceId.toString()},\n'
        '  serviceUuid: ${serviceUuid.toString()},\n'
        '  characteristicUuid: ${characteristicUuid.toString()}\n'
        '}';
  }
}
