import 'package:bloc/bloc.dart';
import 'package:board_client/data/service/chat_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../generated/chat.pb.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatService) : super(ChatInitial());

  List<ChatPreview> chatsList = [];
  static ChatCubit get(context) => BlocProvider.of<ChatCubit>(context);
  final ChatService chatService;

  Future<void> loadChats() async {
    try {
      if (state is! ChatLoaded) {
        emit(ChatLoading());
      }
      final chats = await chatService.getChatsPreview();
      chatsList = chats;
      emit(ChatLoaded(chat: chatsList));
    } catch (e) {
      emit(ChatLoadingFailure(exception: e));
    }
  }

  void deleteChat(ChatPreview chat) async {
    var response = await chatService.deleteChat(chat.id);
    chatsList.removeWhere((it) => it.id == chat.id);
    emit(ChatLoaded(chat: chatsList));
  }

}
