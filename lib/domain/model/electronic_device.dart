// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import 'package:home_automation/domain/model/schedule_model.dart';

enum DeviceType {
  table_lamp,
  light,
  ceiling_lamp,
  ceiling_fan,
  pedestal_fan,
  table_fan,
  desktop,
  fan,
  air_conditioner,
  air_cooler,
  television,
  refrigerator,
  heater,
  water_dispenser,
  water_heater,
  water_filter,
  water_pump,
  washing_machine,
  electric_kettle,
  toaster,
  coffee_maker,
  extractor,
  oven,
  air_purifier,
  dehumidifier,
  juicer,
  exhaust_fan,
  socket,
  blender,
  dish_washer,
  induction_stove,
  iron,
  unknown,
}

// ignore: non_constant_identifier_names
Map<DeviceType, String> IconMap = {
  DeviceType.table_lamp: 'assets/icons/device/table_lamp.png',
  DeviceType.light: 'assets/icons/device/light.png',
  DeviceType.ceiling_lamp: 'assets/icons/device/ceiling_lamp.png',
  DeviceType.ceiling_fan: 'assets/icons/device/ceiling_fan.png',
  DeviceType.pedestal_fan: 'assets/icons/device/pedestal_fan.png',
  DeviceType.table_fan: 'assets/icons/device/table_fan.png',
  DeviceType.desktop: 'assets/icons/device/desktop.png',
  DeviceType.fan: 'assets/icons/device/fan.png',
  DeviceType.air_conditioner: 'assets/icons/device/air_conditioner.png',
  DeviceType.air_cooler: 'assets/icons/device/air_cooler.png',
  DeviceType.television: 'assets/icons/device/television.png',
  DeviceType.refrigerator: 'assets/icons/device/refrigerator.png',
  DeviceType.heater: 'assets/icons/device/heater.png',
  DeviceType.water_dispenser: 'assets/icons/device/water_dispenser.png',
  DeviceType.water_heater: 'assets/icons/device/water_heater.png',
  DeviceType.water_filter: 'assets/icons/device/water_filter.png',
  DeviceType.water_pump: 'assets/icons/device/water_pump.png',
  DeviceType.washing_machine: 'assets/icons/device/washing_machine.png',
  DeviceType.electric_kettle: 'assets/icons/device/electric_kettle.png',
  DeviceType.toaster: 'assets/icons/device/toaster.png',
  DeviceType.coffee_maker: 'assets/icons/device/coffee_maker.png',
  DeviceType.extractor: 'assets/icons/device/extractor.png',
  DeviceType.oven: 'assets/icons/device/oven.png',
  DeviceType.air_purifier: 'assets/icons/device/air_purifier.png',
  DeviceType.dehumidifier: 'assets/icons/device/dehumidifier.png',
  DeviceType.juicer: 'assets/icons/device/juicer.png',
  DeviceType.exhaust_fan: 'assets/icons/device/exhaust_fan.png',
  DeviceType.socket: 'assets/icons/device/socket.png',
  DeviceType.blender: 'assets/icons/device/blender.png',
  DeviceType.dish_washer: 'assets/icons/device/dish_washer.png',
  DeviceType.induction_stove: 'assets/icons/device/induction_stove.png',
  DeviceType.iron: 'assets/icons/device/iron.png',
  DeviceType.unknown: 'assets/icons/device/unknown.png',
};

class ElectronicDevice {
  final RxString name;
  final String id;
  DeviceType type;
  final RxBool state;
  final RxList<ScheduleModel> schedules = <ScheduleModel>[].obs;

  ElectronicDevice({
    required this.id,
    required this.name,
    required this.state,
    required this.type,
  }) {
    _ensureStableEnumValues();
  }

  void _ensureStableEnumValues() {
    assert(DeviceType.table_lamp.index == 0);
    assert(DeviceType.light.index == 1);
    assert(DeviceType.ceiling_lamp.index == 2);
    assert(DeviceType.ceiling_fan.index == 3);
    assert(DeviceType.pedestal_fan.index == 4);
    assert(DeviceType.table_fan.index == 5);
    assert(DeviceType.desktop.index == 6);
    assert(DeviceType.fan.index == 7);
    assert(DeviceType.air_conditioner.index == 8);
    assert(DeviceType.air_cooler.index == 9);
    assert(DeviceType.television.index == 10);
    assert(DeviceType.refrigerator.index == 11);
    assert(DeviceType.heater.index == 12);
    assert(DeviceType.water_dispenser.index == 13);
    assert(DeviceType.water_heater.index == 14);
    assert(DeviceType.water_filter.index == 15);
    assert(DeviceType.water_pump.index == 16);
    assert(DeviceType.washing_machine.index == 17);
    assert(DeviceType.electric_kettle.index == 18);
    assert(DeviceType.toaster.index == 19);
    assert(DeviceType.coffee_maker.index == 20);
    assert(DeviceType.extractor.index == 21);
    assert(DeviceType.oven.index == 22);
    assert(DeviceType.air_purifier.index == 23);
    assert(DeviceType.dehumidifier.index == 24);
    assert(DeviceType.juicer.index == 25);
    assert(DeviceType.exhaust_fan.index == 26);
    assert(DeviceType.socket.index == 27);
    assert(DeviceType.blender.index == 28);
    assert(DeviceType.dish_washer.index == 29);
    assert(DeviceType.induction_stove.index == 30);
    assert(DeviceType.iron.index == 31);
    assert(DeviceType.unknown.index == 32);
  }

  //toJson
  toJson() {
    return {
      'name': name.value,
      'type': type.toString().split('.').last,
      'state': state.value ? 1 : 0,
      'schedules': schedules.map((e) => e.toJson()).toList(),
    };
  }

  //fromJson
  factory ElectronicDevice.fromJson(Map<dynamic, dynamic> json, String id) {
    return ElectronicDevice(
      id: id,
      name: RxString(json['name'] ?? "Unknown"),
      type: json['type'] != null
          ? DeviceType.values
              .firstWhere((e) => e.toString().split('.').last == json['type'])
          : DeviceType.unknown,
      state: json['state'] == 1 ? true.obs : false.obs,
    )..schedules.addAll(
        (json['schedules'] != null)
            ? (json['schedules'] as List)
                .map((e) => ScheduleModel.fromJson(e))
                .toList()
            : [],
      );
  }

  //copyWith
  ElectronicDevice copyWith({
    String? id,
    RxString? name,
    DeviceType? type,
    RxBool? state,
  }) {
    return ElectronicDevice(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      state: state ?? this.state,
    );
  }
}
