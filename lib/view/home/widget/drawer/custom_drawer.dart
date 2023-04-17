import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/app_controller.dart';

import 'dashboard_list_tile.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({
    Key? key,
  }) : super(key: key);

  final AppController appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      width: MediaQuery.of(context).size.width * .95,
      elevation: 10,
      child: Column(
        children: [
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 40, left: 26, right: 26, bottom: 20),
              child: Row(
                children: [
                  Text('Home Automation',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.bodyLarge!.color,
                          fontSize: 24,
                          fontWeight: FontWeight.w600)),
                  const Spacer(),
                  //change theme dark and light button
                  Obx(
                    () => InkWell(
                      onTap: () {
                        appController.toggleTheme();
                      },
                      borderRadius: BorderRadius.circular(30),
                      splashColor: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .color!
                          .withOpacity(0.2),
                      child: appController.themeMode.value == ThemeMode.dark
                          ? Icon(Icons.nightlight_round,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color)
                          : Icon(Icons.wb_sunny,
                              color:
                                  Theme.of(context).textTheme.bodyLarge!.color),
                    ),
                  ),
                  const SizedBox(width: 20),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 10),
              children: [
                DashboardListTile(
                  title: 'Devices',
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed('/devices');
                  },
                ),
                const SizedBox(height: 20),
                DashboardListTile(
                  title: 'Schedule',
                  onTap: () {
                    Navigator.pop(context);
                    Get.toNamed('/schedule');
                  },
                ),
                const SizedBox(height: 20),
                DashboardListTile(
                  title: 'Settings',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                DashboardListTile(
                  title: 'About',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                DashboardListTile(
                  title: 'Logout',
                  onTap: () {
                    Navigator.pop(context);
                    Get.find<AppController>().signOut();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
