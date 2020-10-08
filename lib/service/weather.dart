import 'package:flutter/cupertino.dart';
import 'package:jackpot/apiKey.dart';
import 'package:weather/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_icons/weather_icons.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/apiKey.dart';

Future<Weather> weatherInfo() async{
  print('Function Start');
  String apiKey = weatherApiKey;
  Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  Future.delayed(const Duration(seconds : 1));
  print('address');
  print(position.longitude+position.latitude);
  WeatherFactory wf = new WeatherFactory(apiKey, language: Language.KOREAN);
  Weather w = await wf.currentWeatherByLocation(position.latitude, position.longitude);
  return w;
}

String WeatherFormat(double celcius,double humidity){
  return celcius.toInt().toString() + "℃  "+humidity.toInt().toString()+'%';
}

IconData iconReturn(int weatherConditionCode)
{
  print('find Icon');
  print(weatherConditionCode);
  IconData icon;
  int codeData = weatherConditionCode~/100;
  if(weatherConditionCode == 800){
    icon = Icons.wb_sunny;
  }
  else{
    print('not sunny');
    switch(weatherConditionCode){
      //Group 2xx: Thunderstorm
      case 2:
        icon = WeatherIcons.thunderstorm;
        break;
      case 3:
      //Group 3xx: Drizzle :
        icon = WeatherIcons.rain_mix;
        break;
      case 5:
        //Group 5xx: Rain
        icon = WeatherIcons.rain;
        break;
      case 6:
        //Group 6xx: Snow
        icon = WeatherIcons.snow;
        break;
      case 7:
        //Group 7xx: Atmosphere
        icon = WeatherIcons.dust;
        break;
      case 8:
        //Group 80x: Clouds
        icon = WeatherIcons.cloudy;
        break;
      default:
        break;
    }
  }
  return icon;
}