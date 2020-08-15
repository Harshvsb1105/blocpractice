import 'dart:math';

import 'package:bloc_practice/Data_model/weather.dart';

abstract class WeatherRepository {
  Future<Weather> fetchWeather(String cityName);
  Future<Weather> fetchDetailedWeather(String cityName);
}

class FakeWeatherRepository extends WeatherRepository {
  double cachedTempCelsius;

  @override
  Future<Weather> fetchWeather(String cityName) {
    // Simulate network delay
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final random = Random();

        // Simulate some network error
        if (random.nextBool()) {
          throw NetworkError();
        }

        // Since we're inside a fake repository, we need to cache the temperature
        // in order to have the same one returned for the detailed weather
        cachedTempCelsius = 20 + random.nextInt(15) + random.nextDouble();

        // Return "fetched" weather
        return Weather(
          cityName: cityName,
          // Temperature between 20 and 35.99
          tempCel: cachedTempCelsius,
        );
      },
    );
  }

  @override
  Future<Weather> fetchDetailedWeather(String cityName) {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        return Weather(
          cityName: cityName,
          tempCel: cachedTempCelsius,
          tempFah: cachedTempCelsius * 1.8 + 32,
        );
      },
    );
  }
}

class NetworkError extends Error {}
