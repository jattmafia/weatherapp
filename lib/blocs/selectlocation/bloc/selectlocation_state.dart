part of 'selectlocation_bloc.dart';

@immutable
sealed class SelectlocationState {}

final class SelectlocationInitial extends SelectlocationState {}

final class SelectlocationError extends SelectlocationState {
  final String error;
  SelectlocationError(this.error);
}


final class SelectLocationLoading extends SelectlocationState{}

final class SelectLocationLoadingCurrent extends SelectlocationState{}

final class SelectLocationSucceed extends SelectlocationState{

  SelectLocationSucceed();
}
