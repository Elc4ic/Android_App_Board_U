part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class LoadChatList extends ChatEvent {
  LoadChatList({
    this.completer,
  });

  final Completer? completer;
}
