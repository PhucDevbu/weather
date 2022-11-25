import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {
  final Dio _dio = Dio();
  final String _apiKey = 'GV0AYeGlyuTteWmxSDLe68y5qteCTD1Y';
  API() {
    _dio.options.baseUrl = "http://dataservice.accuweather.com/";
    _dio.interceptors.add(PrettyDioLogger());
  }
  Dio get sendRequest => _dio;
  String get getKey => _apiKey;
}
