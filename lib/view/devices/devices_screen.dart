import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/model/room_model.dart';
import '../home/home_screen_controller.dart';

import '../../domain/model/electronic_device.dart';
import 'widgets/build_edit_device_dialog.dart';
import 'widgets/show_add_room_dialog.dart';

class DevicesScreen extends StatefulWidget {
  const DevicesScreen({super.key});

  @override
  State<DevicesScreen> createState() => _DevicesScreenState();
}

class _DevicesScreenState extends State<DevicesScreen> {
  final HomeScreenController _homeScreenController =
      Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.background,
        iconTheme:
            IconThemeData(color: Theme.of(context).textTheme.bodyLarge!.color),
        centerTitle: true,
        title: Text('Devices',
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        actions: [
          TextButton(
            onPressed: () {
              showAddRoomDialog();
            },
            child: Row(
              children: [
                Icon(Icons.add, color: Theme.of(context).focusColor),
                const SizedBox(width: 5),
                Text('Add Room',
                    style: TextStyle(
                        color: Theme.of(context).focusColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
              ],
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
        child: Obx(() {
          final List<RoomModel> rooms =
              _homeScreenController.selectedHome.value!.rooms;
          return ListView.builder(
            itemBuilder: ((context, roomIndex) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Obx(
                      () => Text(rooms[roomIndex].name.value,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color,
                              fontSize: 20,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  ListView.builder(
                    itemBuilder: ((context, index) {
                      final ElectronicDevice device =
                          rooms[roomIndex].devices[index];
                      return Obx(
                        () => Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color: device.state.value
                                        ? Theme.of(context)
                                            .focusColor
                                            .withOpacity(0.4)
                                        : Theme.of(context)
                                            .shadowColor
                                            .withOpacity(0.4),
                                    blurRadius: 5,
                                    spreadRadius: 0.1)
                              ]),
                          child: ListTile(
                            leading: Image.asset(IconMap[device.type]!,
                                width: 40,
                                height: 40,
                                color: device.state.value
                                    ? Theme.of(context)
                                        .focusColor
                                        .withOpacity(0.8)
                                    : Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.8)),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            tileColor: Theme.of(context).primaryColor,
                            title: Text(device.name.value,
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400)),
                            trailing: SizedBox(
                              child: Wrap(
                                direction: Axis.horizontal,
                                runSpacing: 1,
                                alignment: WrapAlignment.end,
                                spacing: 1,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                        device.state.value
                                            ? Icons.toggle_on_outlined
                                            : Icons.toggle_off_outlined,
                                        color: device.state.value
                                            ? Theme.of(context)
                                                .focusColor
                                                .withOpacity(0.8)
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge!
                                                .color!
                                                .withOpacity(0.8),
                                        size: 30),
                                    onPressed: () {
                                      device.state.value = !device.state.value;
                                    },
                                  ),
                                  //edit button
                                  IconButton(
                                    onPressed: () {
                                      buildDialogBox(context, device);
                                    },
                                    icon: Icon(Icons.edit,
                                        color: Theme.of(context).focusColor,
                                        size: 24),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                    itemCount: rooms[roomIndex].devices.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )
                ],
              );
            }),
            itemCount: rooms.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          );
        }),
      ),
    );
  }
}
