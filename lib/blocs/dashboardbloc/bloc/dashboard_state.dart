part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardLoading extends DashboardState{}

final class DashboardSucceed extends DashboardState{
final  WeatherModel weatherModel;
final FiveDayForecastModel fiveDayForecastModel;
  DashboardSucceed({required this.weatherModel, required this.fiveDayForecastModel});
}

final class DashboardLoadingError extends DashboardState{
  final String error;

  DashboardLoadingError(this.error);
}
