import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../bluetooth_screen_controller.dart';

class BluetoothDeviceConfiguration extends StatelessWidget {
  BluetoothDeviceConfiguration({super.key});

  final BluetoothScreenController _bluetoothScreenController =
      Get.find<BluetoothScreenController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                //Wifi Ssid Text Field
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  controller: _bluetoothScreenController.wifiSSIDController,
                  decoration: const InputDecoration(
                    labelText: 'Wifi SSID',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter wifi ssid';
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                //Wifi Password Text Field
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  controller: _bluetoothScreenController.wifiPasswordController,
                  decoration: const InputDecoration(
                    labelText: 'Wifi Password',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter wifi password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                  controller: _bluetoothScreenController.roomNameController,
                  decoration: const InputDecoration(
                    labelText: 'Room Name',
                    labelStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter room name';
                    }
                  },
                ),
                const SizedBox(
                  height: 16,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _bluetoothScreenController.sendCredentials();
                    }
                  },
                  child: const Text('Send Configuration',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          )),
    );
  }
}
