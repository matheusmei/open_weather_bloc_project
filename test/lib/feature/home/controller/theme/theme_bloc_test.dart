import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_weather_bloc_listener/core/generics/constants/constants.dart';
import 'package:open_weather_bloc_listener/feature/home/controller/theme/theme_bloc.dart';
import 'package:open_weather_bloc_listener/feature/home/controller/weather/weather_bloc.dart';
import '../../../../../dummies/dummies.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late WeatherBloc weatherBloc;
  late ThemeBloc themeBloc;

  setUp(() {
    weatherBloc = MockWeatherBloc();
    themeBloc = ThemeBloc(weatherBloc: weatherBloc);
  });

  tearDown(() {
    themeBloc.close();
    weatherBloc.close();
  });

  group('ThemeBloc', () {
    test('initial state is ThemeState.initial()', () {
      expect(themeBloc.state, ThemeState.initial());
    });

blocTest<ThemeBloc, ThemeState>(
  'emits ThemeState with AppTheme.light when weather is warm',
  build: () {
    when(() => weatherBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([
        Dummies.createDummyWeatherState(
          weather: Dummies.createDummyWeather(
            description: 'Sunny',
            icon: '01d',
            temp: 5,
          ),
    ),]),
    );
    return themeBloc;
  },
  act: (bloc) => bloc.add(ChangeThemeEvent(appTheme: AppTheme.dark)),
  expect: () => [
    ThemeState(appTheme: AppTheme.dark),
  ],
);

    blocTest<ThemeBloc, ThemeState>(
      'emits ThemeState with AppTheme.dark when weather is not warm',
      build: () {
        when(() => weatherBloc.stream).thenAnswer(
          (_) => Stream.fromIterable([
            Dummies.createDummyWeatherState(
          weather: Dummies.createDummyWeather(
            description: 'Sunny',
            icon: '01d',
            temp: kWarmOrNot + 1,
          ),
    ),
          ]),
        );
        return themeBloc;
      },
      act: (bloc) => bloc.add(ChangeThemeEvent(appTheme: AppTheme.light)),
      expect: () => [
        
        ThemeState(appTheme: AppTheme.light),
      ],
    );
  });
}
