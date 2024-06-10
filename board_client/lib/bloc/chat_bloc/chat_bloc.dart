import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:board_client/data/repository/chat_repository.dart';
import 'package:meta/meta.dart';

import '../../data/repository/user_repository.dart';
import '../../generated/chat.pb.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this.chatRepository, this.userRepository) : super(ChatInitial()) {
    on<LoadChatList>(_load);
  }
  final ChatRepository chatRepository;
  final UserRepository userRepository;

  Future<void> _load(
      LoadChatList event,
      Emitter<ChatState> emit,
      ) async {
    try {
      if (state is! ChatLoaded) {
        emit(ChatLoading());
      }
      final chats = await chatRepository.getChatsPreview(userRepository.getToken());
      emit(ChatLoaded(chat: chats));
    } catch (e) {
      emit(ChatLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}
