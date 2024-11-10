import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:board_client/data/service/category_service.dart';
import 'package:board_client/data/service/chat_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';

import '../../data/service/user_service.dart';
import '../../generated/user.pb.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService userService;

  UserCubit(this.userService) : super(UserInitial());

  int newChat = 0;
  bool auth = false;

  static UserCubit get(context) => BlocProvider.of<UserCubit>(context);

  int getChat(context) => newChat;

  void newMessage() {
    newChat += 1;
  }

  void resetNewMessage() {
    newChat = 0;
  }

  Future<void> loadUser(String userId) async {
    try {
      emit(UserLoading());
      final user = await userService.getUserById(userId);
      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserLoadingFailure(exception: e));
    }
  }

  User getUser() => UserService().getUser();

  String? getToken() => UserService().getToken();

  Future<void> changeUser(User user) async {
    await userService.changeUser(user);
  }

  Future<void> changeAvatar(Uint8List avatar) async {
    await userService.updateAvatar(avatar);
  }

  Future<void> logOut() async {
    if (state is! UserInitial) {
      emit(UserLoading());
    }
    await userService.logout();
    GetIt.I<AdService>().initClient("");
    GetIt.I<CategoryService>().initClient("");
    GetIt.I<ChatService>().initClient("");
    auth = false;
    emit(UserInitial());
  }

  Future<void> deleteUser() async {
    if (state is! UserInitial) {
      emit(UserLoading());
    }
    await userService.deleteUser();
    auth = false;
    emit(UserInitial());
  }
}
