import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_automation/domain/model/electronic_device.dart';
import 'package:home_automation/domain/model/user_model.dart';
import 'package:home_automation/domain/provider/auth_provider.dart';
import '../model/room_model.dart';

import '../../app/app_toast.dart';
import '../model/home_model.dart';

class DeviceManager extends GetxService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  DatabaseReference? _databaseReference;
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

  void init() {
    final UserModel? user = Get.find<AuthProvider>().getCurrentUser();
    if (user != null) {
      _database.setPersistenceEnabled(true);
      _database.setPersistenceCacheSizeBytes(10000000);
      _databaseReference = _database.ref("users/${user.uuid}/SMART_IOT");
      _databaseReference!.onValue.listen((event) {
        final DataSnapshot snapshot = event.snapshot;
        print(snapshot.value);
        //print result {Home 1: {bed room: [{state: 0}, {state: 0}, {state: 0}, {state: 0}]}}
        //add snapshot.value to homes
        _homes.clear();
        Map<dynamic, dynamic> homes = snapshot.value as Map<dynamic, dynamic>;
        homes.forEach((key, value) {
          final HomeModel home = HomeModel(
            name: key.toString(),
            rooms: <RoomModel>[].obs,
          );
          Map<dynamic, dynamic> rooms = value as Map<dynamic, dynamic>;
          rooms.forEach((key, value) {
            final RoomModel room = RoomModel(
              name: key.toString(),
              devices: <ElectronicDevice>[].obs,
            );
            if (value is Map<dynamic, dynamic>) {
              Map<dynamic, dynamic> devices = value;
              devices.forEach((key, value) {
                room.devices.add(
                  ElectronicDevice.fromJson(
                    value as Map<String, dynamic>,
                    key.toString(),
                  ),
                );
              });
            } else if (value is List<dynamic>) {
              List<dynamic> devices = value;
              devices.asMap().forEach((index, value) {
                if (value != null) {
                  room.devices.add(
                    ElectronicDevice.fromJson(
                      value as Map<dynamic, dynamic>,
                      index.toString(),
                    ),
                  );
                }
              });
            }
            home.rooms.add(room);
          });
          _homes.add(home);
        });
        final int? selectedHomeIndex = GetStorage().read('selectedHomeIndex');
        if (selectedHomeIndex != null && _homes.isNotEmpty) {
          if (selectedHomeIndex < _homes.length && selectedHomeIndex >= 0) {
            selectHome(_homes[selectedHomeIndex]);
          } else {
            selectHome(_homes[0]);
          }
        }
      });
    }
  }

  Future<void> createHome(String name) async {
    _homes.add(
      HomeModel(
        name: name,
        rooms: <RoomModel>[].obs,
      ),
    );
    AppToast.showSuccess('Home created successfully');
  }

  void updateDeviceState(ElectronicDevice device, String roomName) {
    _databaseReference!
        .child('${selectedHome.value!.name}/$roomName/${device.id}')
        .update(device.toJson());
  }
}
