import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_practice/Data_model/weather.dart';
import 'package:bloc_practice/Repository/WeatherRepo.dart';
import 'package:equatable/equatable.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc(this._weatherRepository) : super(WeatherInitial());
  WeatherRepository _weatherRepository;

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    yield WeatherLoading();
    if (event is GetWeather) {
      try {
        _mapGetWeathertoState(event);
      } on NetworkError {
        yield WeatherFailure("Couldn't Fetch");
      }
    } else if (event is GetDetailedWeather) {
      try {
        _mapGetDetailedWeathertoState(event);
      } on NetworkError {
        yield WeatherFailure("Couldn't Fetch");
      }
    }
  }

  Stream<WeatherState> _mapGetWeathertoState(GetWeather event) async* {
    final weather = await _weatherRepository.fetchWeather(event.cityName);
    yield WeatherLoaded(weather: weather);
  }

  Stream<WeatherState> _mapGetDetailedWeathertoState(
      GetDetailedWeather event) async* {
    final weather =
        await _weatherRepository.fetchDetailedWeather(event.cityName);
    yield WeatherLoaded(weather: weather);
  }
}
