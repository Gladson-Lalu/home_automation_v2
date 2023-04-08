import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../domain/model/room_model.dart';
import '../../domain/repository/device_manager.dart';

import '../../domain/model/home_model.dart';

class HomeScreenController extends GetxController {
  final DeviceManager _homeRepository = Get.find<DeviceManager>();
  RxList<HomeModel> get homes => _homeRepository.homes;
  Rx<HomeModel?> get selectedHome => _homeRepository.selectedHome;

  final RxInt selectedRoomIndex = 0.obs;

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
}
