
import 'dart:io';

import 'package:weather_console_app/weather.dart';
import 'package:weather_console_app/weather_api_client.dart';

void main(List<String> arguments) async {
  if(arguments.length != 1) { 
    print('Syntax error: dart bin/main.dart <city>');
    return; 
  }
  final cityName = arguments.first;
  
  final weatherApiClient = WeatherApiClient();

  try {
final currentWeather = await weatherApiClient.getCurrentWeather(cityName);
  print('Current Weather for $cityName');
  print(currentWeather);
  print('-------------------------------');
  }on WeatherApiException catch(e){
   print('error: $e');
  }on SocketException catch(_){
   print('Could not fetch ... ! Check connection!');
  }catch(error){
    print(error);
  }


try {
final weeklyForecast = await weatherApiClient.getWeeklyForecast(cityName);
  print('Weekly forecast for $cityName');
  // ignore: avoid_function_literals_in_foreach_calls
  weeklyForecast.forEach((forecast){
    print(forecast);
    print('=============');

  });
  
  }on WeatherApiException catch(e){
   print('error: $e');
  }on SocketException catch(_){
   print('Could not fetch ... ! Check connection!');
  }catch(error){
    print(error);
  }
}