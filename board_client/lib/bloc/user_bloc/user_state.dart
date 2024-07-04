part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  UserLoaded({
    required this.user,
  });

  final User user;
}

class UserLoadingFailure extends UserState {
  UserLoadingFailure({
    this.exception,
  });

  final Object? exception;
}