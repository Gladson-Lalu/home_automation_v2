import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/model/schedule_model.dart';

import '../../../domain/model/electronic_device.dart';
import '../../../domain/model/room_model.dart';
import '../schedule_screen_controller.dart';

void showAddScheduleDialog() {
  final context = Get.context!;
  final scheduleScreenController = Get.find<ScheduleScreenController>();
  final Rx<RoomModel?> selectedRoom = Rx<RoomModel?>(null);
  final Rx<ElectronicDevice?> selectedDevice = Rx<ElectronicDevice?>(null);
  final ScheduleModel scheduleModel = ScheduleModel(
      startTime: TimeOfDay.now().obs, endTime: TimeOfDay.now().obs);
  Get.dialog(
    Dialog(
      backgroundColor: Theme.of(context).colorScheme.background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Schedule',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => DropdownButtonFormField<RoomModel>(
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                dropdownColor: Theme.of(context).colorScheme.background,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  labelText: 'Room',
                  labelStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                value: selectedRoom.value,
                items: scheduleScreenController.rooms.map((RoomModel room) {
                  return DropdownMenuItem<RoomModel>(
                    value: room,
                    child: Text(room.name.capitalize!),
                  );
                }).toList(),
                onChanged: (RoomModel? value) {
                  selectedRoom.value = value;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => DropdownButtonFormField<ElectronicDevice>(
                dropdownColor: Theme.of(context).colorScheme.background,
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: InputDecoration(
                  fillColor: Theme.of(context).colorScheme.background,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).textTheme.bodyLarge!.color!,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).focusColor,
                    ),
                  ),
                  labelText: 'Device',
                  labelStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                value: selectedDevice.value,
                items: selectedRoom.value == null
                    ? []
                    : selectedRoom.value!.devices
                        .map((ElectronicDevice device) {
                        return DropdownMenuItem<ElectronicDevice>(
                          value: device,
                          child: Text(
                            device.name.value.capitalize!,
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      }).toList(),
                onChanged: (ElectronicDevice? value) {
                  selectedDevice.value = value;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            //pick start time and end time using time picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Text(
                    'Start Time',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => TextButton(
                      onPressed: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: scheduleModel.startTime.value,
                        );
                        if (picked != null) {
                          scheduleModel.startTime.value = picked;
                        }
                      },
                      child: Text(
                        scheduleModel.startTime.value.format(context),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ]),
                Column(children: [
                  Text(
                    'End Time',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => TextButton(
                      onPressed: () async {
                        final TimeOfDay? picked = await showTimePicker(
                          context: context,
                          initialTime: scheduleModel.endTime.value,
                        );
                        if (picked != null) {
                          scheduleModel.endTime.value = picked;
                        }
                      },
                      child: Text(
                        scheduleModel.endTime.value.format(context),
                        style: TextStyle(
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.black)),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      final ElectronicDevice device = selectedDevice.value!;
                      device.schedules.add(scheduleModel);
                      scheduleScreenController.updateSchedule(
                          device, selectedRoom.value!);
                    });
                  },
                  child:
                      const Text('Add', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
