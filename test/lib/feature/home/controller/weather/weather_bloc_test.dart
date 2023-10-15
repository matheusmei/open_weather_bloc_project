import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_bloc_listener/core/domain/repositories/weather_repository.dart';
import 'package:open_weather_bloc_listener/core/models/custom_error.dart';
import 'package:open_weather_bloc_listener/feature/home/controller/weather/weather_bloc.dart';

import '../../../../../dummies/dummies.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  late WeatherRepository weatherRepository;
  late WeatherBloc weatherBloc;

  setUp(() {
    weatherRepository = MockWeatherRepository();
    weatherBloc = WeatherBloc(weatherRepository: weatherRepository);
  });

  group('WeatherBloc', () {
   final weather = Dummies.createDummyWeather(
      description: 'Sunny',
      icon: '01d',
      temp: 20,
      name: 'New York',
      country: 'US',
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [loading, loaded] when FetchWeatherEvent is added',
      build: () {
        when(() => weatherRepository.fetchWeather('New York'))
            .thenAnswer((_) async => weather);
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeatherEvent(city: 'New York')),
      expect: () => [
        WeatherState.initial().copyWith(status: WeatherStatus.loading),
        WeatherState.initial().copyWith(status: WeatherStatus.loaded, weather: weather),
      ],
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [loading, error] when FetchWeatherEvent throws CustomError',
      build: () {
        when(() => weatherRepository.fetchWeather('New York'))
            .thenThrow(CustomError());
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeatherEvent(city: 'New York')),
      expect: () => [
        WeatherState.initial().copyWith(status: WeatherStatus.loading),
        WeatherState.initial().copyWith(status: WeatherStatus.error, error: CustomError()),
      ],
    );
  });
}