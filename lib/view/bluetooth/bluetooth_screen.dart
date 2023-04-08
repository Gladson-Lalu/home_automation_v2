import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/model/bluetooth_state.dart';
import 'widgets/bluetooth_device_configuration.dart';
import 'package:system_settings/system_settings.dart';

import 'bluetooth_screen_controller.dart';
import 'widgets/app_bar.dart';
import 'widgets/devices_list_view.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  final BluetoothScreenController _controller =
      Get.put<BluetoothScreenController>(BluetoothScreenController());
  @override
  void dispose() {
    Get.delete<BluetoothScreenController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: buildAppBar(context),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        color: Theme.of(context).colorScheme.background,
        child: Obx(
          () {
            if (_controller.state.value == BluetoothServiceState.turningOn ||
                _controller.state.value == BluetoothServiceState.turningOff ||
                _controller.state.value == BluetoothServiceState.connecting ||
                _controller.state.value ==
                    BluetoothServiceState.disconnecting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (_controller.state.value == BluetoothServiceState.off) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/bluetooth_off.png',
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                      color: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .color!
                          .withOpacity(0.9),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Bluetooth is off',
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).cardColor,
                        )),
                        onPressed: SystemSettings.bluetooth,
                        child: Text('Turn on Bluetooth',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .color))),
                  ],
                ),
              );
            } else if (_controller.state.value ==
                BluetoothServiceState.unavailable) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/bluetooth_unavailable.png',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text('Bluetooth is unavailable'),
                  ],
                ),
              );
            } else if (_controller.state.value == BluetoothServiceState.on ||
                _controller.state.value == BluetoothServiceState.disconnected) {
              return const BluetoothDeviceListBuilder();
            } else {
              return BluetoothDeviceConfiguration();
            }
          },
        ),
      ),
    );
  }
}
