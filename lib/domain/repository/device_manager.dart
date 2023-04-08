import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../model/room_model.dart';

import '../../app/app_toast.dart';
import '../model/electronic_device.dart';
import '../model/home_model.dart';

class DeviceManager extends GetxService {
  final RxList<HomeModel> _homes = <HomeModel>[].obs;
  RxList<HomeModel> get homes => _homes;

  final Rx<int?> _selectedHomeIndex = Rx<int?>(null);
  Rx<HomeModel?> get selectedHome => _selectedHomeIndex.value != null
      ? _homes[_selectedHomeIndex.value!].obs
      : Rx<HomeModel?>(null);

  void selectHome(HomeModel home) {
    _selectedHomeIndex.value = _homes.indexOf(home);

    selectedHome.value = home;
    GetStorage().write('selectedHomeIndex', _selectedHomeIndex.value);
  }

  @override
  void onInit() {
    //TESTING DATA
    _homes.add(
      HomeModel(
        id: 1,
        name: 'Home 1'.obs,
        rooms: [
          RoomModel(
              id: 1,
              name: 'Room 1'.obs,
              devices: [
                ElectronicDevice(id: 1, name: 'Device 1'.obs, state: false.obs),
                ElectronicDevice(id: 2, name: 'Device 2'.obs, state: false.obs),
              ].obs),
          RoomModel(
              id: 2,
              name: 'Room 2'.obs,
              devices: [
                ElectronicDevice(id: 1, name: 'Device 1'.obs, state: false.obs),
                ElectronicDevice(id: 2, name: 'Device 2'.obs, state: false.obs),
              ].obs),
        ].obs,
      ),
    );
    _homes.add(
      HomeModel(
        id: 2,
        name: 'Home 2'.obs,
        rooms: [
          RoomModel(
              id: 1,
              name: 'Room 1'.obs,
              devices: [
                ElectronicDevice(id: 1, name: 'Device 1'.obs, state: false.obs),
                ElectronicDevice(id: 2, name: 'Device 2'.obs, state: false.obs),
              ].obs),
          RoomModel(
              id: 2,
              name: 'Room 2'.obs,
              devices: [
                ElectronicDevice(id: 1, name: 'Device 1'.obs, state: false.obs),
                ElectronicDevice(id: 2, name: 'Device 2'.obs, state: false.obs),
              ].obs),
        ].obs,
      ),
    );
    _selectedHomeIndex.value = _homes.isEmpty ? null : 0;
  }

  Future<void> createHome(String name) async {
    final int id = _homes.length + 1;
    _homes.add(
      HomeModel(
        id: id,
        name: name.obs,
        rooms: <RoomModel>[].obs,
      ),
    );
    AppToast.showSuccess('Home created successfully');
  }
}
