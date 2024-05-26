part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  LoginEvent(
    this.username,
    this.password, {
    this.completer,
  });

  final String username;
  final String password;
  final Completer? completer;
}

class SignInEvent extends AuthEvent {
  SignInEvent(
    this.username,
    this.password,
    this.phone, {
    this.completer,
  });

  final String username;
  final String password;
  final String phone;
  final Completer? completer;
}
