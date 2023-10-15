import 'package:flutter_test/flutter_test.dart';
import 'package:open_weather_bloc_listener/feature/settings/controller/temp_settings/temp_settings_bloc.dart';

void main() {
  group('TempSettingsBloc', () {
    late TempSettingsBloc tempSettingsBloc;

    setUp(() {
      tempSettingsBloc = TempSettingsBloc();
    });

    test('initial state is correct', () {
      expect(tempSettingsBloc.state, TempSettingsState.initial());
    });

    test('toggle temp unit changes the state correctly', () {
      final expectedStates = [
        TempSettingsState(tempUnit: TempUnit.fahrenheit),
        TempSettingsState(tempUnit: TempUnit.celsius),
        TempSettingsState(tempUnit: TempUnit.fahrenheit),
        TempSettingsState(tempUnit: TempUnit.celsius),
      ];

      expectLater(
        tempSettingsBloc.stream,
        emitsInOrder(expectedStates),
      );

      tempSettingsBloc.add(ToggleTempUnitEvent());
      tempSettingsBloc.add(ToggleTempUnitEvent());
      tempSettingsBloc.add(ToggleTempUnitEvent());
      tempSettingsBloc.add(ToggleTempUnitEvent());
    });
  });
}