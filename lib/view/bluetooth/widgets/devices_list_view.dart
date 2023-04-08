import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bluetooth_screen_controller.dart';
import '../../../domain/model/bluetooth_device.dart';

class BluetoothDeviceListBuilder extends StatefulWidget {
  const BluetoothDeviceListBuilder({
    Key? key,
  }) : super(key: key);

  @override
  State<BluetoothDeviceListBuilder> createState() =>
      _BluetoothDeviceListBuilderState();
}

class _BluetoothDeviceListBuilderState
    extends State<BluetoothDeviceListBuilder> {
  final BluetoothScreenController _bluetoothController =
      Get.put<BluetoothScreenController>(BluetoothScreenController());

  @override
  void initState() {
    super.initState();
    _bluetoothController.getDevices();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final List<BluetoothDeviceModel> devices = _bluetoothController.devices;
        if (devices.isNotEmpty) {
          return ListView.builder(
            itemCount: _bluetoothController.devices.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: devices[index].isConnectable
                      ? Theme.of(context).cardColor.withAlpha(60)
                      : Theme.of(context).cardColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: ListTile(
                  enabled: devices[index].isConnectable,
                  onTap: () {
                    _bluetoothController.connectToDevice(devices[index]);
                  },
                  title: Text(
                    devices[index].name,
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                  subtitle: Text(devices[index].address,
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color)),
                ),
              );
            },
          );
        } else {
          return Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text('No device found',
                    style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    )),
                const SizedBox(height: 10),
                const Text('Make sure your device is on and discoverable'),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Theme.of(context).cardColor),
                  ),
                  onPressed: () {
                    _bluetoothController.getDevices();
                  },
                  child: Text(
                    'Scan again',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.titleSmall!.color,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
