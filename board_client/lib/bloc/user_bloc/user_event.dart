part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUser extends UserEvent {
  LoadUser(
    this.userId, {
    this.completer,
  });

  final Int64 userId;
  final Completer? completer;
}

class LoadComments extends UserEvent {
  LoadComments(
    this.userId, {
    this.completer,
  });

  final Int64 userId;
  final Completer? completer;
}

class LoadUserComments extends UserEvent {
  LoadUserComments(
    this.userId,
    this.token, {
    this.completer,
  });

  final Int64 userId;
  final String? token;
  final Completer? completer;
}
