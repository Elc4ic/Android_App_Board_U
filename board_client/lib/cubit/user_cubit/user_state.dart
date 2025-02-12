part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  UserLoaded({
    required this.user,
    required this.online,
  });

  final User user;
  final bool online;
}

class UserUpdated extends UserState {}

class UserLoadingFailure extends UserState {
  UserLoadingFailure({
    this.exception,
  });

  final Object? exception;
}
