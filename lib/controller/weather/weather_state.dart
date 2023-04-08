class WeatherState {
  final int index;

  const WeatherState(this.index);

  static const loading = WeatherState(0);
  static const loaded = WeatherState(1);
  static const locationNotSelected = WeatherState(2);
}
