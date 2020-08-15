import 'package:bloc_practice/Repository/WeatherRepo.dart';
import 'package:bloc_practice/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'UI/SearchPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather Demo',
        home: BlocProvider(
          create: (context) => WeatherBloc(FakeWeatherRepository()),
          child: SearchPage(),
        ));
  }
}
