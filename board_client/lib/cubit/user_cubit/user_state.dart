part of 'user_cubit.dart';

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

class CommentsLoaded extends UserState {
  CommentsLoaded({required this.user, required this.comments});

  final List<Comment> comments;
  final User user;
}

class UserCommentsLoaded extends UserState {
  UserCommentsLoaded({required this.comments});

  final List<Comment> comments;
}

class UserLoadingFailure extends UserState {
  UserLoadingFailure({
    this.exception,
  });

  final Object? exception;
}
