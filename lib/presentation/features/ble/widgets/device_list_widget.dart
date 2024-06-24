import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceListWidget extends StatelessWidget {
  static const _defaultMargin = 12.0;

  final List<BluetoothDevice> devices;
  final Function(BluetoothDevice) onDeviceTap;

  const DeviceListWidget({
    required this.devices,
    required this.onDeviceTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            "Devices found:",
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const SizedBox(height: _defaultMargin),
        Expanded(
          child: ListView.separated(
            itemCount: devices.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text("Device ID: ${devices[index].id.id}"),
                subtitle: Text("Device name: ${devices[index].name}"),
                onTap: () => onDeviceTap(devices[index]),
                trailing: const Icon(Icons.chevron_right),
              );
            },
            separatorBuilder: (context, index) {
              return Container(height: 1, color: Colors.grey);
            },
          ),
        ),
      ],
    );
  }
}
