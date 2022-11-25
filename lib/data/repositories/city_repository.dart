import 'package:dio/dio.dart';
import 'package:weather/data/models/city_model.dart';
import 'package:weather/data/repositories/api/api.dart';

class CityRepository {
  API api = API();
  Future<List<CityModel>> fetchKeys() async {
    try {
      Response response = await api.sendRequest
          .get('/locations/v1/topcities/50?apikey=${api.getKey}');
      List<dynamic> citys = response.data;
      return citys.map((city) => CityModel.fromJson(city)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
