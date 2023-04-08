import 'package:get/get.dart';

import 'room_model.dart';

class HomeModel {
  final int id;
  final RxString name;
  final RxList<RoomModel> rooms;

  HomeModel({
    required this.id,
    required this.name,
    required this.rooms,
  });

  void setDeviceState(int roomId, int deviceId, bool state) {
    rooms[roomId].devices[deviceId].state.value = state;
  }

  //toJson
  toJson() {
    return {
      'id': id,
      'name': name.value,
      'rooms': rooms.map((room) => room.toJson()).toList(),
    };
  }
}
