import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/home_screen_controller.dart';

import '../../../domain/model/home_model.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({
    super.key,
    required this.home,
  });
  final HomeModel home;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.find<HomeScreenController>().selectHome(home);
      },
      child: Stack(children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Get.find<HomeScreenController>().selectedHome.value == home
                  ? Colors.blue
                  : Colors.transparent,
              width: 4,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Center(
            child: Text(
              home.name.value,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: IconButton(
            onPressed: () {
              Get.find<HomeScreenController>().deleteHome(home);
            },
            icon: Icon(
              Icons.folder_delete,
              color: Colors.red.shade400,
              size: 30,
            ),
          ),
        ),
      ]),
    );
  }
}
