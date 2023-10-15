import 'dart:convert';
import 'package:weather_console_app/config.dart';
import 'package:weather_console_app/weather.dart';
import 'package:http/http.dart' as http;

class WeatherApiClient{
  Future<Weather> getCurrentWeather(String cityName) async {
    //https://api.weatherapi.com/v1/current.json?key=c49f45de66dd44ba9c5194506230410&q=London&aqi=no

    final url = '${Config().baseUrl}/${Config().currentUrl}?key=${Config().apiKey}&q=$cityName';
    print(url);

    final response = await http.get(Uri.parse(url));


    if(response.statusCode != 200){
      print('request failed with status ${response.statusCode}');
      throw WeatherApiException('error getting weather for $cityName');
    }

    final Map<String, dynamic> jsonResponse = Map.castFrom(jsonDecode(response.body));

    if(jsonResponse.isEmpty){
      throw WeatherApiException('weather for city $cityName not found');
    }

    return Weather.fromJson(jsonResponse);
  }

  Future<List<Forecast>> getWeeklyForecast(String cityName) async {
    //https://api.weatherapi.com/v1/forecast.json?key=c49f45de66dd44ba9c5194506230410&q=London&days=7&aqi=no&alerts=no

    final url = '${Config().baseUrl}/${Config().currentUrl}?key=${Config().apiKey}&q=$cityName&days=7';
    print(url);

    final response = await http.get(Uri.parse(url));
     
    if(response.statusCode != 200){
      print('request failed with status ${response.statusCode}');
      throw WeatherApiException('error getting forecast for $cityName');
    }


    
    final jsonResponse = jsonDecode(response.body) ;
    final forecastList = List<Map<String, dynamic>>.from(jsonResponse['forecast']['forecastday'] );

    if(jsonResponse['forecast'] == null){
      throw WeatherApiException('forecast for city $cityName not found');
    }else{
      print('fdsaddasda');
    }

    return forecastList.map((forecastData) => Forecast.fromJson(forecastData)).toList();
  }
}

class WeatherApiException implements Exception {
  final String message; 
  const WeatherApiException(this.message);
}