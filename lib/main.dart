import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'view/schedule/schedule_screen.dart';
import 'domain/provider/bluetooth_serial_service.dart';
import 'domain/provider/location_provider.dart';
import 'domain/repository/device_manager.dart';
import 'view/auth_wrapper/auth_wrapper.dart';
import 'view/devices/devices_screen.dart';
import 'view/home/home_screen.dart';
import 'view/splash/splash_screen.dart';

import 'app/theme.dart';
import 'controller/app_controller.dart';
import 'view/home_selection/home_selection_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  dotenv.load(fileName: '.env');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppController _appController = Get.put(AppController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        onInit: () {
          Get.put(LocationProvider());
          Get.put(BluetoothSerialService());
          Get.put(DeviceManager());
        },
        title: 'Home Automation',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        debugShowCheckedModeBanner: false,
        themeMode: _appController.themeMode.value,
        routes: {
          '/': (context) => const SplashScreen(),
          '/auth': (context) => const AuthWrapper(),
          '/home': (context) => HomeScreen(),
          '/homeSelection': (context) => HomeSelectionScreen(),
          '/devices': (context) => const DevicesScreen(),
          '/schedule': (context) => const ScheduleScreen()
        },
      ),
    );
  }
}
