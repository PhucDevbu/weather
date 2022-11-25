part of 'weather_bloc.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoadingState extends WeatherState {}

class WeatherLoadedState extends WeatherState {
  final WeatherModel weathers;
  WeatherLoadedState({required this.weathers});
}

class WeatherErrorState extends WeatherState {
  final String error;

  WeatherErrorState(this.error);
}
