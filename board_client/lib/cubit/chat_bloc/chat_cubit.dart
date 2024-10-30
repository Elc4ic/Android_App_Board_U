import 'package:bloc/bloc.dart';
import 'package:board_client/data/service/chat_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/service/user_service.dart';
import '../../generated/chat.pb.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chatService, this.userService) : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of<ChatCubit>(context);

  final ChatService chatService;
  final UserService userService;

  Future<void> loadChats() async {
    try {
      if (state is! ChatLoaded) {
        emit(ChatLoading());
      }
      final chats = await chatService.getChatsPreview();
      emit(ChatLoaded(chat: chats));
    } catch (e) {
      emit(ChatLoadingFailure(exception: e));
    }
  }
}
