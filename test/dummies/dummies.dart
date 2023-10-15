import 'package:open_weather_bloc_listener/core/generics/exceptions/weather_exception.dart';
import 'package:open_weather_bloc_listener/core/models/custom_error.dart';
import 'package:open_weather_bloc_listener/core/models/direct_geocoding.dart';
import 'package:open_weather_bloc_listener/core/models/weather.dart';
import 'package:open_weather_bloc_listener/feature/home/controller/weather/weather_bloc.dart';

class Dummies {
  static Weather createDummyWeather({
    String description = 'dummy',
    String icon = 'dummy',
    double temp = 0,
    double tempMin = 0,
    double tempMax = 0,
    String name = 'dummy',
    String country = 'dummy',
  }) {
    return Weather(
      description: description,
      icon: icon,
      temp: temp,
      tempMin: tempMin,
      tempMax: tempMax,
      name: name,
      country: country,
      lastUpdated: DateTime.now(),
    );
  }

final dummyWeather = Dummies.createDummyWeather(
  description: 'dummy',
  icon: 'dummy',
  temp: 0,
  tempMin: 0,
  tempMax: 0,
  name: 'dummy',
  country: 'dummy',
);




 static DirectGeocoding createDummyDirectGeocoding({
    String name = 'dummy',
    double lat = 0,
    double lon = 0,
    String country = 'dummy',
  }) {
    return DirectGeocoding(
      name: name,
      lat: lat,
      lon: lon,
      country: country,
    );
  }



  static WeatherException createDummyWeatherException({
    String message = 'dummy',
  }) {
    return WeatherException(message);
  }


    static WeatherState createDummyWeatherState({
    WeatherStatus status = WeatherStatus.initial,
    Weather? weather,
    CustomError? error,
  }) {
    return WeatherState(
      status: status,
      weather: weather ?? Weather.initial(),
      error: error ?? CustomError(),
    );
  }


final dummyWeatherState = Dummies.createDummyWeatherState(
  status: WeatherStatus.loaded,
  weather: Dummies.createDummyWeather(
    description: 'Sunny',
    icon: '01d',
    temp: 20.0,
    tempMin: 18.0,
    tempMax: 22.0,
    name: 'Sample City',
    country: 'US',
  ),
  error: CustomError(errMsg: 'Sample Error'),
);




}




