import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends StatelessWidget {
  final Function onTap2;
  final BluetoothDevice device;

  BluetoothDeviceListEntry({required this.onTap2, required this.device});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap2(),
      leading: Icon(Icons.devices),
      title: Text(device.name ?? "Unknown device"),
      subtitle: Text(device.address.toString()),
      trailing: FlatButton(
        child: Text('Connect'),
        onPressed: onTap2(),
        color: Colors.blue,
      ),
    );
  }
}
