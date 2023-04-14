import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../controller/app_controller.dart';
import '../../domain/model/bluetooth_state.dart';
import '../../domain/provider/bluetooth_serial_service.dart';
import '../../domain/repository/device_manager.dart';

import '../../app/app_toast.dart';
import '../../domain/model/bluetooth_device.dart';

class BluetoothScreenController extends GetxController {
  final BluetoothSerialService _bluetoothSerialService =
      Get.find<BluetoothSerialService>();
  final Rx<BluetoothServiceState> state = BluetoothServiceState.unavailable.obs;
  final RxList<BluetoothDeviceModel> _devices = <BluetoothDeviceModel>[].obs;
  RxList<BluetoothDeviceModel> get devices => _devices;
  late final StreamSubscription<BluetoothServiceState> _stateSubscription;
  late final StreamSubscription<String> _readDataSubscription;
  final GetStorage _getStorage = GetStorage();

  String? _connectedDeviceName;
  String get connectedDeviceName => _connectedDeviceName ?? "Unknown";

  final TextEditingController roomNameController = TextEditingController();
  final TextEditingController wifiSSIDController = TextEditingController();
  final TextEditingController wifiPasswordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _bluetoothSerialService.init();

    _stateSubscription = _bluetoothSerialService.state.listen((state) {
      switch (state) {
        case BluetoothServiceState.turningOff:
          AppToast.show('Bluetooth is turning off');
          break;
        case BluetoothServiceState.off:
          AppToast.show('Bluetooth is off');
          break;
        case BluetoothServiceState.turningOn:
          AppToast.show('Bluetooth is turning on');
          break;
        case BluetoothServiceState.on:
          AppToast.show('Bluetooth is on');
          break;
        case BluetoothServiceState.unavailable:
          AppToast.show('Bluetooth is unavailable');
          break;
        case BluetoothServiceState.connected:
          AppToast.show('Bluetooth is connected');
          break;
        case BluetoothServiceState.disconnected:
          AppToast.show('Bluetooth is disconnected');
          break;
        case BluetoothServiceState.connecting:
          AppToast.show('Bluetooth is connecting');
          break;
        case BluetoothServiceState.disconnecting:
          AppToast.show('Bluetooth is disconnecting');
          break;
      }
    });

    _readDataSubscription = _bluetoothSerialService.readData.listen((data) {
      AppToast.show(data);
    });

    state.bindStream(_bluetoothSerialService.state);
    wifiSSIDController.text = _getStorage.read('wifiSSID') ?? '';
    wifiPasswordController.text = _getStorage.read('wifiPassword') ?? '';
  }

  @override
  void onClose() {
    disconnect();
    _stateSubscription.cancel();
    _readDataSubscription.cancel();
  }

  //get devices
  void getDevices() async {
    final List<BluetoothDevice> device = await _bluetoothSerialService.devices;
    _devices.value = device
        .map((BluetoothDevice e) => BluetoothDeviceModel(
              name: e.name ?? "Unknown",
              address: e.address,
              isConnectable: e.isBonded,
            ))
        .toList();
  }

  void connectToDevice(BluetoothDeviceModel device) {
    _bluetoothSerialService.connectToDevice(device.address);
    _connectedDeviceName = device.name;
  }

  void disconnect() {
    _bluetoothSerialService.disconnect();
  }

  void sendCredentials() {
    try {
      _getStorage.write('wifiSSID', wifiSSIDController.text);
      _getStorage.write('wifiPassword', wifiPasswordController.text);
      final String home =
          Get.find<DeviceManager>().selectedHome.value!.name.value;
      final email = Get.find<AppController>().currentUser!.email;
      final password = Get.find<AppController>().currentUser!.password;
      final String message =
          "emailS${email}emailE:passS${password}passE:homeS${home}homeE:roomS${roomNameController.text}roomE:wifiS${wifiSSIDController.text}wifiE:wPassS${wifiPasswordController.text}wPassE";
      _bluetoothSerialService.writeData(message);
    } catch (e) {
      AppToast.show('Error: ${e.toString()}');
    }
  }
}
