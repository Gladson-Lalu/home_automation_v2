import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../home/home_screen_controller.dart';
import 'widgets/create_home_card.dart';
import 'widgets/home_card.dart';

class HomeSelectionScreen extends StatelessWidget {
  HomeSelectionScreen({super.key});

  final HomeScreenController controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        title: Text(
          'Home Selection',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyLarge!.color,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Obx(
        () {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, crossAxisSpacing: 16, mainAxisSpacing: 16),
            itemCount: controller.homes.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const CreateHomeCard();
              }
              return HomeCard(
                home: controller.homes[index - 1],
              );
            },
          );
        },
      ),
    );
  }
}
