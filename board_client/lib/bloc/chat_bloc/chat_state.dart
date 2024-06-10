part of 'chat_bloc.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  ChatLoaded({
    required this.chat,
  });

  final List<ChatPreview> chat;
}

class ChatLoadingFailure extends ChatState {
  ChatLoadingFailure({
    this.exception,
  });

  final Object? exception;
}
