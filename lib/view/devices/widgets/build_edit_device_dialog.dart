import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/model/room_model.dart';
import '../../home/home_screen_controller.dart';

import '../../../domain/model/electronic_device.dart';

Future<dynamic> buildDialogBox(
    BuildContext context, ElectronicDevice device, RoomModel room) {
  TextEditingController nameController = TextEditingController();
  nameController.text = device.name.value;
  DeviceType selectedType = device.type;
  return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(20),
          backgroundColor: Theme.of(context).colorScheme.background,
          title: const Text('Edit Device'),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.4,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              children: [
                //outlined text field for device name
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Device Name',
                    labelStyle: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).shadowColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).focusColor.withOpacity(0.6)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color:
                              Theme.of(context).shadowColor.withOpacity(0.4)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  cursorColor: Theme.of(context).textTheme.bodyLarge!.color,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 20),

                const SizedBox(height: 20),
                //device type dropdown
                DropdownButtonFormField(
                  value: selectedType,
                  decoration: InputDecoration(
                    labelText: 'Device Type',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyLarge!.color),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).textTheme.bodyLarge!.color!),
                    ),
                  ),
                  items: DeviceType.values
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e.toString().split('.').last.splitMapJoin(
                                    RegExp(r'[_]'),
                                    onMatch: (m) => ' ',
                                    onNonMatch: (n) =>
                                        n[0].toUpperCase() + n.substring(1),
                                  ),
                            ),
                          ))
                      .toList(),
                  hint: Text('Select Device Type',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color)),
                  dropdownColor: Theme.of(context).colorScheme.background,
                  style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                  borderRadius: BorderRadius.circular(10),
                  onChanged: (value) {
                    if (value != null) {
                      selectedType = value;
                    }
                  },
                ),
              ],
            ),
          ),
          scrollable: true,
          //actions for the dialog
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  )),
            ),
            TextButton(
              onPressed: () {
                if (nameController.text.isNotEmpty) {
                  device.name.value = nameController.text;
                  device.type = selectedType;
                  nameController.clear();
                  Get.find<HomeScreenController>().updateDevice(device, room);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Please enter a name'),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              },
              child: Text(
                'Save',
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
            ),
          ],
        );
      });
}
