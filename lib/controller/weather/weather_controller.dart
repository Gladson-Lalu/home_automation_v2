import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'weather_state.dart';
import '../../domain/model/home_location_model.dart';

import '../../app/app_toast.dart';
import '../../domain/model/weather_model.dart';
import '../../domain/repository/weather_repository.dart';
import '../../view/home/home_screen_controller.dart';

class WeatherController extends GetxController {
  final WeatherRepository weatherRepository = WeatherRepository();
  final box = GetStorage();

  final Rx<Weather> weather = Rx<Weather>(Weather.empty());

  final _state = Rx<WeatherState>(WeatherState.loading);
  WeatherState get state => _state.value;
  late final String homeId;

  @override
  void onInit() {
    homeId =
        Get.find<HomeScreenController>().selectedHome.value!.name.toString();
    super.onInit();
    _getWeather();
  }

  void _getWeather() async {
    _state.value = WeatherState.loading;
    final location = box.read('location:$homeId');
    if (location != null) {
      final HomeLocation homeLocation = HomeLocation.fromJson(location);
      try {
        weather.value = await weatherRepository.getWeather(
            latitude: homeLocation.latitude, longitude: homeLocation.longitude);
        _state.value = WeatherState.loaded;
      } catch (e) {
        AppToast.showError('Error getting weather');
        _state.value = WeatherState.locationNotSelected;
      }
    } else {
      _state.value = WeatherState.locationNotSelected;
    }
  }

  void setLocationHomeLocation(HomeLocation homeLocation) {
    box.write('location:$homeId', homeLocation.toJson());
    _getWeather();
  }
}
