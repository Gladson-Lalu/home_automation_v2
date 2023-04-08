import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bluetooth_screen_controller.dart';
import '../../../domain/model/bluetooth_state.dart';

AppBar buildAppBar(BuildContext context) {
  final BluetoothScreenController bluetoothController =
      Get.find<BluetoothScreenController>();
  return AppBar(
    centerTitle: true,
    iconTheme:
        IconThemeData(color: Theme.of(context).textTheme.bodyLarge!.color),
    backgroundColor: Theme.of(context).colorScheme.background,
    elevation: 0,
    title: Obx(
      () {
        if (bluetoothController.state.value ==
            BluetoothServiceState.connected) {
          return Text('Connected to ${bluetoothController.connectedDeviceName}',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600));
        } else if (bluetoothController.state.value ==
            BluetoothServiceState.off) {
          return Text('Bluetooth',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600));
        } else if (bluetoothController.state.value ==
            BluetoothServiceState.turningOff) {
          return Text('Bluetooth Turning Off',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600));
        } else if (bluetoothController.state.value ==
            BluetoothServiceState.turningOn) {
          return Text('Bluetooth Turning On',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600));
        } else if (bluetoothController.state.value ==
            BluetoothServiceState.unavailable) {
          return Text('Bluetooth Unavailable',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600));
        } else if (bluetoothController.state.value ==
            BluetoothServiceState.connecting) {
          return Text(
              'Connecting to ${bluetoothController.connectedDeviceName}',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600));
        }

        //disconnecting
        else if (bluetoothController.state.value ==
            BluetoothServiceState.disconnecting) {
          return Text(
              'Disconnecting from ${bluetoothController.connectedDeviceName}',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600));
        } else {
          return Text('Connect Device',
              style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .color!
                      .withOpacity(0.8),
                  fontSize: 16,
                  fontWeight: FontWeight.w400));
        }
      },
    ),
    actions: [
      Obx(
        () {
          if (bluetoothController.state.value == BluetoothServiceState.on ||
              bluetoothController.state.value ==
                  BluetoothServiceState.disconnected) {
            return IconButton(
              onPressed: () {
                bluetoothController.getDevices();
              },
              icon: Icon(
                Icons.refresh,
                color: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .color!
                    .withOpacity(0.8),
              ),
            );
          } else if (bluetoothController.state.value ==
              BluetoothServiceState.connected) {
            return TextButton(
              onPressed: (() {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        title: const Text('Disconnect Device'),
                        content: Text(
                            'Are you sure you want to disconnect from ${bluetoothController.connectedDeviceName}',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color)),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color))),
                          TextButton(
                              onPressed: () {
                                bluetoothController.disconnect();
                                Navigator.pop(context);
                              },
                              child: Text('Disconnect',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color))),
                        ],
                      );
                    });
              }),
              child: Text('Disconnect',
                  style: TextStyle(
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withRed(255))),
            );
          } else {
            return const SizedBox();
          }
        },
      )
    ],
  );
}
