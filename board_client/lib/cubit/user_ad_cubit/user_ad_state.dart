part of 'user_ad_cubit.dart';

@immutable
sealed class UserAdState {}

final class UserAdInitial extends UserAdState {}

class UserAdLoading extends UserAdState {}

class UserAdLoaded extends UserAdState {
  UserAdLoaded({
    required this.userAds,
  });

  final List<Ad> userAds;
}

class UserAdLoadingFailure extends UserAdState {
  UserAdLoadingFailure({
    this.exception,
  });

  final Object? exception;
}
