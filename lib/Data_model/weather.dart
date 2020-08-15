import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Weather extends Equatable {
  final String cityName;
  final double tempCel;
  final double tempFah;

  Weather({@required this.cityName, @required this.tempCel, this.tempFah});

  @override
  List<Object> get props => [cityName, tempCel, tempFah];
}
