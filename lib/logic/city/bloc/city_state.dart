part of 'city_bloc.dart';

@immutable
abstract class CityState {}

class CityInitial extends CityState {}

class CityLoadingState extends CityState {}

class CityLoadedState extends CityState {
  final List<CityModel> citys;
  CityLoadedState({required this.citys});
}

class CityErrorState extends CityState {
  final String error;

  CityErrorState(this.error);
}
