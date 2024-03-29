import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String baseUrl = "https://api.openweathermap.org/data/2.5/";

class API {
  final Dio _dio = Dio();

  API() {
    
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(PrettyDioLogger());
  }

  Dio get sendRequest => _dio;
}