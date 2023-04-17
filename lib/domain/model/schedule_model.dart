import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScheduleModel {
  Rx<TimeOfDay> startTime;
  Rx<TimeOfDay> endTime;

  ScheduleModel({
    required this.startTime,
    required this.endTime,
  });

  //fromJson
  factory ScheduleModel.fromJson(Map<dynamic, dynamic> json) {
    return ScheduleModel(
      startTime: TimeOfDay(
        hour: json['startTime']['hour'],
        minute: json['startTime']['minute'],
      ).obs,
      endTime: TimeOfDay(
        hour: json['endTime']['hour'],
        minute: json['endTime']['minute'],
      ).obs,
    );
  }

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'startTime': {
        'hour': startTime.value.hour,
        'minute': startTime.value.minute,
      },
      'endTime': {
        'hour': endTime.value.hour,
        'minute': endTime.value.minute,
      },
    };
  }
}
