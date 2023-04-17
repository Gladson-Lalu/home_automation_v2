import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/model/electronic_device.dart';
import '../../../domain/model/room_model.dart';
import '../schedule_screen_controller.dart';

void showDisplaySchedule(ElectronicDevice device, RoomModel room) {
  Get.dialog(
    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(Get.context!).colorScheme.background,
          borderRadius: BorderRadius.circular(10),
        ),
        height: Get.height * 0.5,
        width: Get.width * 0.8,
        child: Obx(
          () {
            if (device.schedules.isEmpty) {
              return Center(
                child: Text(
                  "No Schedule",
                  style: TextStyle(
                      color: Theme.of(Get.context!).textTheme.bodyLarge!.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              );
            }
            return ListView.builder(
              itemCount: device.schedules.length,
              padding: const EdgeInsets.all(10),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Text(
                            "${index + 1}",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      device.schedules[index].startTime.value);
                              if (picked != null) {
                                device.schedules[index].startTime.value =
                                    picked;
                                Get.find<ScheduleScreenController>()
                                    .updateSchedule(device, room);
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Start Time",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  device.schedules[index].startTime.value
                                      .format(context),
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
                          ),
                          const SizedBox(width: 16),
                          InkWell(
                            onTap: () async {
                              final TimeOfDay? picked = await showTimePicker(
                                  context: context,
                                  initialTime:
                                      device.schedules[index].endTime.value);
                              if (picked != null) {
                                device.schedules[index].endTime.value = picked;
                                Get.find<ScheduleScreenController>()
                                    .updateSchedule(device, room);
                              }
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "End Time",
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  device.schedules[index].endTime.value
                                      .format(context),
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
                          ),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.delete,
                            color: Theme.of(context).colorScheme.error),
                        onPressed: () {
                          device.schedules.removeAt(index);
                          Get.find<ScheduleScreenController>()
                              .updateSchedule(device, room);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    ),
  );
}
