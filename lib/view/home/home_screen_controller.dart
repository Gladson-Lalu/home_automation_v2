import 'package:get/get.dart';
import '../../domain/model/electronic_device.dart';
import '../../domain/model/room_model.dart';
import '../../domain/repository/device_manager.dart';

import '../../domain/model/home_model.dart';

class HomeScreenController extends GetxController {
  final DeviceManager _homeRepository = Get.find<DeviceManager>();
  RxList<HomeModel> get homes => _homeRepository.homes;
  Rx<HomeModel?> get selectedHome => _homeRepository.selectedHome;

  final RxInt selectedRoomIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.find<DeviceManager>().init();
  }

  void selectHome(HomeModel home) {
    _homeRepository.selectHome(home);
    selectedRoomIndex.value = 0;
    Get.offAllNamed('/home');
  }

  void createHome(String name) {
    _homeRepository.createHome(name);
  }

  void deleteHome(HomeModel home) {
    _homeRepository.homes.remove(home);
  }

  void updateDevice(ElectronicDevice device, RoomModel room) {
    _homeRepository.updateDeviceState(device, room.name);
  }
}
