import 'package:get/get.dart';
import 'electronic_device.dart';

class RoomModel {
  final int id;
  final RxString name;
  final RxList<ElectronicDevice> devices;

  RoomModel({
    required this.id,
    required this.name,
    required this.devices,
  });

  //toJson
  toJson() {
    return {
      'id': id,
      'name': name.value,
      'devices': devices.map((device) => device.toJson()).toList(),
    };
  }
}
