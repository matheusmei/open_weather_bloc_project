import 'package:get_it/get_it.dart';
import 'package:open_weather_bloc_listener/core/data/data_source/weather_api_data_source.dart';
import 'package:open_weather_bloc_listener/core/domain/repositories/weather_repository.dart';

class AppGetIt {
  static final instance = GetIt.instance;

  const AppGetIt();

  void setUpRemoteClientMock({required WeatherApiDataSource remoteClient}) {
    instance.registerLazySingleton<WeatherApiDataSource>(() => remoteClient);
  }

  void setUp() {
    instance.registerLazySingleton<WeatherApiDataSource>(
        () => WeatherApiDataSource(httpClient: instance()));


    instance.registerFactory<WeatherRepository>(() => WeatherRepository(
        weatherApiServices: instance<WeatherApiDataSource>()));
  }
}
