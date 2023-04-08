import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../bluetooth/bluetooth_screen.dart';

void showAddRoomDialog() {
  final context = Get.context!;
  Get.dialog(
    Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      backgroundColor: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add Device',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 20,
                          fontWeight: FontWeight.w600)),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon:
                        Icon(Icons.close, color: Theme.of(context).focusColor),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Steps to add device',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              Text('1. Enable Bluetooth',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              Text('2. Pair device through Bluetooth settings',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              Text('3. Select device from list of paired devices',
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                    Get.dialog(const Dialog.fullscreen(
                      child: BluetoothScreen(),
                    ));
                  },
                  child: Text('Connect Device',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600)),
                ),
              ),
              const SizedBox(height: 20),
            ]),
      ),
    ),
  );
}
