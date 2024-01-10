import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather/core/api.dart';
import 'package:weather/data/model/fivedayweather.dart';
import 'package:weather/data/model/weathermodel.dart';
import 'package:weather/utils/constants.dart';

class UserRepository {
  final _api = API();

  Future<WeatherModel> getWeather(
      {required String lat, required String long}) async {
    try {
      Response response = await _api.sendRequest
          .get("weather?lat=$lat&lon=$long&units=metric&appid=$appid");

      return WeatherModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<WeatherModel> getWeatherfromcity(
      {required String city, required String zipcode}) async {
    try {
      Response response = await _api.sendRequest
          .get("weather?q=$city,$zipcode&units=metric&appid=$appid");

      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response!.statusCode == 404) {
        var message = jsonDecode(e.response.toString());

        return throw message["message"].toString();
      } else {
        throw e.toString();
      }
    }
  }

  Future<FiveDayForecastModel> getWeatherhourly(
      {required String lat, required String long}) async {
    try {
      Response response = await _api.sendRequest.get(
          "forecast?lat=$lat&lon=$long&units=metric&exclude=hourly,current&appid=$appid");

      return FiveDayForecastModel.fromJson(response.data);
    } catch (e) {
      throw e.toString();
    }
  }
}
