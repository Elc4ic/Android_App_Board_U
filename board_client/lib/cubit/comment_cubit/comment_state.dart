part of 'comment_cubit.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentsLoaded extends CommentState {
  CommentsLoaded({required this.user, required this.comments});

  final List<Comment> comments;
  final User user;
}

class UserCommentsLoaded extends CommentState {
  UserCommentsLoaded({required this.comments});

  final List<Comment> comments;
}

class CommentLoadingFailure extends CommentState {
  CommentLoadingFailure({
    this.exception,
  });

  final Object? exception;
}
