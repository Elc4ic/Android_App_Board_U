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
