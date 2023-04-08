import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controller/weather/weather_controller.dart';
import '../../../../controller/weather/weather_state.dart';
import '../../../../domain/provider/location_provider.dart';
import 'weather_detail_tile.dart';
import 'weather_icon_and_temperature.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetX(
      init: WeatherController(),
      builder: (WeatherController controller) {
        if (controller.state == WeatherState.loading) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: Center(
              child: CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.secondary,
                  strokeWidth: 2),
            ),
          );
        } else if (controller.state == WeatherState.loaded) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 850),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    child: Column(children: [
                      const SizedBox(height: 20),
                      WeatherIconAndTemperature(
                          weather: controller.weather.value),
                      Text(
                        controller.weather.value.description.capitalize!,
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      //feels like
                      Wrap(
                        children: [
                          Text(
                            'Feels like ',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w100),
                          ),
                          Text(
                            '${controller.weather.value.feelsLike}°',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .color!
                            .withOpacity(0.5),
                        thickness: 1,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          WeatherDetailTile(
                            assetPath: 'assets/icons/weather/wind.png',
                            title: '${controller.weather.value.wind} km/h',
                          ),
                          const SizedBox(width: 30),
                          WeatherDetailTile(
                            assetPath: 'assets/icons/weather/humidity.png',
                            title: '${controller.weather.value.humidity} %',
                          ),
                          const SizedBox(width: 30),
                          WeatherDetailTile(
                            assetPath: 'assets/icons/weather/cloudy.png',
                            title: '${controller.weather.value.cloudiness} %',
                          ),
                        ],
                      )
                    ]),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Center(
              child: InkWell(
            onTap: () {
              Get.find<LocationProvider>().getCurrentLocation().then((value) {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor:
                            Theme.of(context).colorScheme.background,
                        title: Text('Location',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .color)),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Set ${value.city} as the home location. You can change this location in settings.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Do you want to continue?',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 16,
                                  ),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancel',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .color))),
                          TextButton(
                              onPressed: () {
                                controller.setLocationHomeLocation(value);
                                Navigator.pop(context);
                              },
                              child: Text('Continue',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Theme.of(context).focusColor))),
                        ],
                      );
                    });
              });
            },
            child: Text('Set your home location ',
                style: Theme.of(context)
                    .textTheme
                    .labelMedium!
                    .copyWith(fontSize: 26, fontWeight: FontWeight.w600)),
          ));
        }
      },
    );
  }
}
