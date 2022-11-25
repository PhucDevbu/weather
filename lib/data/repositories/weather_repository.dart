import 'package:dio/dio.dart';
import 'package:weather/data/models/weather_model.dart';
import 'package:weather/data/repositories/api/api.dart';

class WeatherRepository {
  final API _api = API();
  Future<WeatherModel> fetchWeather(String locationKey) async {
    try {
      Response response = await _api.sendRequest.get(
          'forecasts/v1/daily/5day/$locationKey?apikey=${_api.getKey}&metric=true');
      dynamic weathers = response.data;
      return WeatherModel.fromJson(weathers);
    } catch (e) {
      rethrow;
    }
  }
}
