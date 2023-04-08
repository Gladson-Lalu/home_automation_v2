import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../home_screen_controller.dart';
import '../weather/weather.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      pinned: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      backgroundColor: Theme.of(context).cardColor,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .color!
                    .withOpacity(0.2),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: SvgPicture.asset('assets/icons/menuAlt1.svg',
                    width: 30,
                    height: 30,
                    // ignore: deprecated_member_use
                    color: Theme.of(context).textTheme.labelMedium!.color),
              ),
              const SizedBox(width: 10),
              Text(
                  'Welcome ${Get.find<HomeScreenController>().selectedHome.value!.name} !',
                  style: GoogleFonts.niconne(
                      color: Theme.of(context).textTheme.labelMedium!.color,
                      fontSize: 30,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(30),
                splashColor: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .color!
                    .withOpacity(0.2),
                onTap: () {
                  Get.offAllNamed('/homeSelection');
                },
                child: Icon(
                  Icons.logout,
                  size: 30,
                  // ignore: deprecated_member_use
                  color: Theme.of(context).textTheme.labelMedium!.color,
                ),
              ),
            ],
          ),
        ],
      ),
      flexibleSpace: const FlexibleSpaceBar(
        background: WeatherWidget(),
      ),
      expandedHeight: MediaQuery.of(context).size.height * 0.45,
    );
  }
}
