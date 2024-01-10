import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/data/model/weathermodel.dart';
import 'package:weather/data/repository/user_repository.dart';
import 'package:weather/data/sharedpreference/sharedpreferences.dart';

part 'selectlocation_event.dart';
part 'selectlocation_state.dart';

class SelectlocationBloc
    extends Bloc<SelectlocationEvent, SelectlocationState> {
  UserRepository userRepository = UserRepository();
  WeatherModel weathermodel = WeatherModel();

  SelectlocationBloc() : super(SelectlocationInitial()) {
    on<LocationRequest>((event, emit) async {
      final city = event.city;
      final zipcode = event.zipCode;

      if (city.isEmpty || zipcode.isEmpty) {
        return emit(SelectlocationError("Please Fill All Fields"));
      } else {
        try {
          emit(SelectLocationLoading());
          weathermodel = await userRepository.getWeatherfromcity(
              city: city, zipcode: zipcode);
          await SharePreferences.saveLocation(
              weathermodel.coord!.lat!.toString(),
              weathermodel.coord!.lon!.toString());

          emit(SelectLocationSucceed());
        } catch (e) {
          return emit(SelectlocationError(e.toString()));
        }
      }
    });

    on<CurrentLocationRequest>((event, emit) async {
      var permission = await Geolocator.checkPermission();
      var serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return emit(SelectlocationError('Location services are disabled.'));
      }
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return emit(SelectlocationError('Location permissions are denied'));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return emit(SelectlocationError(
            'Location permissions are permanently denied, we cannot request permissions.'));
      }
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        try {
          emit(SelectLocationLoadingCurrent());
          Position location = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best);
          weathermodel = await userRepository.getWeather(
              lat: location.latitude.toString(),
              long: location.longitude.toString());
          print(location);
          await SharePreferences.saveLocation(
              weathermodel.coord!.lat!.toString(),
              weathermodel.coord!.lon!.toString());
          return emit(SelectLocationSucceed());
        } catch (e) {
          return emit(SelectlocationError(e.toString()));
        }
      }
    });
  }
}
