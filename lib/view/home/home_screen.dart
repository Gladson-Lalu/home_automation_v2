import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_automation/domain/model/room_model.dart';
import 'package:home_automation/view/devices/widgets/show_add_room_dialog.dart';
import 'package:home_automation/view/home/widget/drawer/custom_drawer.dart';
import 'package:home_automation/view/home_selection/home_selection_screen.dart';

import '../../domain/model/electronic_device.dart';
import 'home_screen_controller.dart';
import 'widget/app_bar/home_app_bar.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final HomeScreenController controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return controller.selectedHome.value == null
            ? HomeSelectionScreen()
            : Scaffold(
                backgroundColor: Theme.of(context).colorScheme.background,
                drawer: CustomDrawer(),
                body: DoubleBackToCloseApp(
                  snackBar: const SnackBar(
                    content: Text('Tap back again to leave'),
                  ),
                  child: CustomScrollView(
                    slivers: [
                      const HomeAppBar(),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                      ),
                      buildRoomHeader(),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                      ),
                      buildGridList(),
                    ],
                  ),
                ),
              );
      },
    );
  }

  SliverPadding buildGridList() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      sliver: Obx(
        () {
          if (controller.selectedHome.value!.rooms.isEmpty) {
            final BuildContext context = Get.context!;
            return SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('No Room has been added yet',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontSize: 18, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      showAddRoomDialog();
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Theme.of(context).focusColor,
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text('Add Room',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    fontSize: 15, fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          final RoomModel room = controller
              .selectedHome.value!.rooms[controller.selectedRoomIndex.value];
          return SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.3,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return buildDeviceCard(context, room, index);
              },
              childCount: controller.selectedHome.value!
                  .rooms[controller.selectedRoomIndex.value].devices.length,
            ),
          );
        },
      ),
    );
  }

  SliverToBoxAdapter buildRoomHeader() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: Get.width * 0.08,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          scrollDirection: Axis.horizontal,
          itemCount: controller.selectedHome.value!.rooms.length,
          itemBuilder: (context, index) {
            return Obx(
              () => InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  controller.selectedRoomIndex.value = index;
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: controller.selectedRoomIndex.value == index
                          ? Theme.of(context).focusColor
                          : Theme.of(context).colorScheme.background,
                      width: 2,
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Center(
                    child: Text(
                        controller
                            .selectedHome.value!.rooms[index].name.capitalize!,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 15, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildDeviceCard(BuildContext context, RoomModel room, int index) {
    final ElectronicDevice device = room.devices[index];
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 0, top: 20, bottom: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                IconMap[device.type]!,
                height: 52,
                width: 52,
                color: Theme.of(context).focusColor,
                fit: BoxFit.cover,
              ),
              Obx(
                () => Switch(
                  inactiveTrackColor: Colors.grey,
                  inactiveThumbColor: Colors.white,
                  value: device.state.value,
                  onChanged: (value) {
                    final ElectronicDevice device0 = device.copyWith(
                      state: value.obs,
                    );
                    controller.updateDevice(
                      device0,
                      room,
                    );
                  },
                  activeColor: Theme.of(context).focusColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            device.name.value,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyLarge!.color,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
