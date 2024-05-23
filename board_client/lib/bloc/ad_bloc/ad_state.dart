part of 'ad_bloc.dart';

@immutable
abstract class AdState {}

class AdInitial extends AdState {}

class AdLoading extends AdState {}

class AdLoaded extends AdState {
  AdLoaded({
    required this.ad,
  });

  final Ad ad;
}

class AdLoadingFailure extends AdState {
  AdLoadingFailure({
    this.exception,
  });

  final Object? exception;
}
