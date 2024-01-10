part of 'selectlocation_bloc.dart';

@immutable
sealed class SelectlocationEvent {}

class LocationRequest extends SelectlocationEvent {
  final String city;
  final String zipCode;
  LocationRequest({required this.city, required this.zipCode});
}

class CurrentLocationRequest extends SelectlocationEvent {

}
