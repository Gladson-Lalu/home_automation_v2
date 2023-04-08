import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../domain/provider/auth_provider.dart';
import '../view/home/home_screen_controller.dart';

import '../app/app_toast.dart';
import '../domain/model/user_model.dart';

class AppController extends GetxController {
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;
  UserModel? _user;
  UserModel? get currentUser {
    _user ??= authProvider.getCurrentUser();
    return _user;
  }

  RxBool isLoading = false.obs;

  final AuthProvider authProvider = Get.put<AuthProvider>(AuthProvider());

  void signIn({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      AppToast.show('Email and password cannot be empty');
      return;
    }
    isLoading.value = true;
    UserModel? user = await authProvider.signIn(email, password);
    if (user != null) {
      Get.offAllNamed('/home');
      user = user;
    }
    isLoading.value = false;
  }

  void signUp(
      {required String email,
      required String password,
      required String confirmPassword,
      required String name}) async {
    if (password != confirmPassword) {
      AppToast.show('Password does not match');
      return;
    }
    if (password.length < 6) {
      AppToast.show('Password must be at least 6 characters');
      return;
    }
    if (name.length < 3) {
      AppToast.show('Name must be at least 3 characters');
      return;
    }
    isLoading.value = true;
    UserModel? user = await authProvider.signUp(email, password, name);
    if (user != null) {
      Get.offAllNamed('/home');
      user = user;
    }
    isLoading.value = false;
  }

  void signOut() async {
    await authProvider.signOut();
    Get.offAllNamed('/auth');
    Get.delete<HomeScreenController>();
  }

  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.light;
    }
  }
}
