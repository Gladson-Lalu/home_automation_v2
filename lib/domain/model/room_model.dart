import 'package:get/get.dart';
import 'electronic_device.dart';

class RoomModel {
  final String name;
  final RxList<ElectronicDevice> devices;

  RoomModel({
    required this.name,
    required this.devices,
  });

  //toJson
  toJson() {
    return {
      'name': name,
      'devices': devices.map((device) => device.toJson()).toList(),
    };
  }
}
