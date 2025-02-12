part of 'ad_cubit.dart';

@immutable
abstract class AdState {}

class AdInitial extends AdState {}

class AdLoading extends AdState {}

class AdLoaded extends AdState {
  AdLoaded({
    required this.ad,
    required this.online,
  });

  final bool online;
  final Ad ad;
}

class AdLoadingFailure extends AdState {
  AdLoadingFailure({
    this.exception,
  });

  final Object? exception;
}
