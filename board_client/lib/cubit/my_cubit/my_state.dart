part of 'my_cubit.dart';

@immutable
sealed class MyState {}

final class MyInitial extends MyState {}

class MyLoading extends MyState {}

class MyLoaded extends MyState {
  MyLoaded({
    required this.myAds,
  });

  final List<Ad> myAds;
}

class MyLoadingFailure extends MyState {
  MyLoadingFailure({
    this.exception,
  });

  final Object? exception;
}