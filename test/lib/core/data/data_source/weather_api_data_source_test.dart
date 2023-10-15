import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_bloc_listener/core/data/data_source/weather_api_data_source.dart';
import 'package:open_weather_bloc_listener/core/generics/exceptions/weather_exception.dart';

import '../../../../dummies/dummies.dart'; // Importe o arquivo de dummies.

class MockHttpClient extends Mock implements http.Client {}

void main() async {
  await dotenv.load();
  final mockHttpClient = MockHttpClient();
  final geoService = WeatherApiDataSource(httpClient: mockHttpClient);

  setUp(() {
    registerFallbackValue(Uri());
  });

  group("getDirectGeocoding", () {
    test(
        "getDirectGeocoding should return DirectGeocoding on successful response",
        () async {
      final city = "New York";
      final dummyDirectGeocoding = Dummies.createDummyDirectGeocoding(
        name: 'New York',
        lat: 40.71427,
        lon: -74.00597,
        country: 'US',
      );
      final jsonEncoded = json.encode([dummyDirectGeocoding.toJson()]);

      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response(jsonEncoded, 200));

      final result = await geoService.getDirectGeocoding(city);

      expect(result, equals(dummyDirectGeocoding));
    });

    test(
        "getDirectGeocoding should return a appropriate exception when API response is empty ",
        () async {
      final city = "New York";
      final jsonEncoded = json.encode([]);

      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response(jsonEncoded, 200));

      expect(() async => await geoService.getDirectGeocoding(city),
          throwsA(isA<WeatherException>()));
    });


  
    test("getWeather should throw an exception on 400 response", () async {
      final directGeocoding = Dummies.createDummyDirectGeocoding(
        name: 'New York',
        lat: 40.71427,
        lon: -74.00597,
        country: 'US',
      );

      when(() => mockHttpClient.get(any()))
          .thenAnswer((_) async => http.Response("Error message", 404));

      expect(() async => await geoService.getWeather(directGeocoding),
          throwsA(isA<Exception>()));
    });


  
  });






}
