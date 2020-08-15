import 'package:bloc_practice/Data_model/weather.dart';
import 'package:bloc_practice/Repository/WeatherRepo.dart';
import 'package:bloc_practice/bloc/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherDetailPage extends StatefulWidget {
  final Weather weather;

  WeatherDetailPage({Key key, @required this.weather}) : super(key: key);

  @override
  _WeatherDetailPageState createState() => _WeatherDetailPageState();
}

class _WeatherDetailPageState extends State<WeatherDetailPage> {
  WeatherRepository weatherRepository;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    BlocProvider.of<WeatherBloc>(context)
      ..add(GetDetailedWeather(widget.weather.cityName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather Detail"),
        ),
        body: Container(
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return CircularProgressIndicator();
              } else if (state is WeatherLoaded) {
                return buildColumnWithData(context, state.weather);
              }
              return Container();
            },
          ),
        ));
  }

  Column buildColumnWithData(context, Weather weather) {
    return Column(
      children: <Widget>[
        Text(weather.cityName),
        Text("${weather.tempCel.toStringAsFixed(1)}"),
        Text("${weather.tempFah.toStringAsFixed(1)}"),
      ],
    );
  }
}
