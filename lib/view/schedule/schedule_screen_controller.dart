import 'package:get/get.dart';
import '../../domain/model/electronic_device.dart';
import '../../domain/model/room_model.dart';
import '../../domain/repository/device_manager.dart';

class ScheduleScreenController extends GetxController {
  final DeviceManager _deviceManager = Get.find<DeviceManager>();
  RxList<RoomModel> get rooms => _deviceManager.selectedHome.value!.rooms;

  void updateSchedule(ElectronicDevice device, RoomModel room) {
    _deviceManager.updateDeviceState(device, room.name);
  }
}
