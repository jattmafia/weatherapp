import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/data/model/fivedayweather.dart';
import 'package:weather/data/model/weathermodel.dart';
import 'package:weather/data/repository/user_repository.dart';
import 'package:weather/data/sharedpreference/sharedpreferences.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  // ignore: prefer_typing_uninitialized_variables
  var lat,long;
  FiveDayForecastModel fiveDayForecastModel = FiveDayForecastModel();
  WeatherModel weatherModel = WeatherModel();
  UserRepository userRepository = UserRepository();
  DashboardBloc() : super(DashboardLoading()) {
    on<DashboardgetWeatherRequest>((event, emit) async {
     
      try {
       
        emit(DashboardLoading());
        lat = await SharePreferences.getLatitude();
        long = await SharePreferences.getLongitude();
        weatherModel = await userRepository.getWeather(lat: lat.toString(), long: long.toString());
        fiveDayForecastModel = await userRepository.getWeatherhourly(lat: lat.toString(),long: long.toString());
        
        emit(DashboardSucceed(weatherModel: weatherModel,fiveDayForecastModel: fiveDayForecastModel));
      } catch (e) {
        emit(DashboardLoadingError(e.toString()));
      }
    });

   

  }
}
