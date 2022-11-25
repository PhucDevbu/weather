import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository = WeatherRepository();
  WeatherBloc() : super(WeatherLoadingState()) {
    on<WeatherEvent>((event, emit) {});
    on<FetchWeatherEvent>(
      (event, emit) async {
        try {
          WeatherModel weathers =
              await weatherRepository.fetchWeather(event.locationKey);
          emit(WeatherLoadedState(weathers: weathers));
        } catch (ex) {
          rethrow;
        }
      },
    );
  }
}
