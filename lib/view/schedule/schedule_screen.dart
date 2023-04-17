import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'schedule_screen_controller.dart';
import 'widgets/show_display_schedule.dart';
import '../../domain/model/room_model.dart';

import '../../domain/model/electronic_device.dart';
import 'widgets/show_add_schedule.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final ScheduleScreenController _scheduleScreenController =
      Get.put(ScheduleScreenController());

  @override
  void dispose() {
    Get.delete<ScheduleScreenController>();
    super.dispose();
  }

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
        title: Text('Schedule',
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
                fontSize: 20,
                fontWeight: FontWeight.w600)),
        actions: [
          InkWell(
            onTap: () {
              showAddScheduleDialog();
            },
            child: Container(
              margin: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Row(
                  children: [
                    Text(
                      'Add Schedule',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    Icon(
                      Icons.add,
                      color: Theme.of(context).primaryColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: Obx(() {
        final List<List<dynamic>> devices = [];

        for (final RoomModel room in _scheduleScreenController.rooms) {
          for (final ElectronicDevice device in room.devices) {
            if (device.schedules.isNotEmpty) {
              devices.add([room, device]);
            }
          }
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          itemCount: devices.length,
          itemBuilder: (BuildContext context, int index) {
            final ElectronicDevice device =
                devices[index][1] as ElectronicDevice;
            return InkWell(
              onTap: () {
                showDisplaySchedule(device, devices[index][0] as RoomModel);
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      spreadRadius: 1,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          IconMap[device.type]!,
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              device.name.value,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              devices[index][0].name.toString().capitalize!,
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).focusColor.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Obx(
                            () => Text(
                              "${device.schedules.length} Schedule",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          size: 20,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
