part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent {}

class FetchWeatherEvent extends WeatherEvent {
  final String locationKey;

  FetchWeatherEvent(this.locationKey);
}
