import 'package:get/get.dart';

import 'room_model.dart';

class HomeModel {
  final String name;
  final RxList<RoomModel> rooms;

  HomeModel({
    required this.name,
    required this.rooms,
  });

  void setDeviceState(int roomId, int deviceId, bool state) {
    rooms[roomId].devices[deviceId].state.value = state;
  }

  //toJson
  toJson() {
    return {
      'name': name,
      'rooms': rooms.map((room) => room.toJson()).toList(),
    };
  }
}
