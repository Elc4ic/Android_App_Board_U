part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class Loading extends AuthState {}

class LoginSuccess extends AuthState {
/*  LoginSuccess({
    required this.token,
    required this.user,
  });

  final User user;
  final String token;*/
}

class SingInSuccess extends AuthState {
/*  SingInSuccess({
    required this.user,
  });

  final User user;*/
}

class Failure extends AuthState {
  Failure({
    this.exception,
  });

  final Object? exception;
}
