import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_bloc_listener/core/data/data_source/weather_api_data_source.dart';
import 'package:open_weather_bloc_listener/core/domain/repositories/weather_repository.dart';
import 'package:open_weather_bloc_listener/core/generics/exceptions/weather_exception.dart';
import 'package:open_weather_bloc_listener/core/models/custom_error.dart';


import '../../../../dummies/dummies.dart';

class MockWeatherApiServices extends Mock implements WeatherApiDataSource {}

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late WeatherRepository weatherRepository;
  late MockWeatherApiServices mockWeatherApiDataSource;

  setUp(() {
    mockWeatherApiDataSource = MockWeatherApiServices();
    weatherRepository = WeatherRepository(
      weatherApiServices: mockWeatherApiDataSource,
    );
  });

  group('fetchWeather', () {
    const city = 'New York';
   final  directGeocoding = Dummies.createDummyDirectGeocoding(
        name: 'New York',
        lat: 40.71427,
        lon: -74.00597,
        country: 'US',
      );;

    final tempWeather = Dummies.createDummyWeather(
      description: 'Sunny',
      icon: '01d',
      temp: 20,
    );  

  final weather = Dummies.createDummyWeather(
      description: 'Sunny',
      icon: '01d',
      temp: 20,
      name: 'New York',
      country: 'US',
    );

    test('should return weather on successful response', () async {
      when(() => mockWeatherApiDataSource.getDirectGeocoding(city))
          .thenAnswer((_) async => directGeocoding);
      when(() => mockWeatherApiDataSource.getWeather(directGeocoding))
          .thenAnswer((_) async => tempWeather);

      final result = await weatherRepository.fetchWeather(city);

      expect(result, equals(weather));
    });

    test('should throw CustomError on WeatherException', () async {
      when(() => mockWeatherApiDataSource.getDirectGeocoding(city))
          .thenThrow(WeatherException('Error message'));

      expect(() async => await weatherRepository.fetchWeather(city),
          throwsA(isA<CustomError>()));
    });

    test('should throw CustomError on other exceptions', () async {
      when(() => mockWeatherApiDataSource.getDirectGeocoding(city))
          .thenThrow(Exception('Error message'));

      expect(() async => await weatherRepository.fetchWeather(city),
          throwsA(isA<CustomError>()));
    });
  });
}