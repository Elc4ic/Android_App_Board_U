import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:fixnum/fixnum.dart';

import '../../data/service/user_service.dart';
import '../../generated/user.pb.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userService) : super(UserInitial());

  final UserService userService;

  static UserCubit get(context) => BlocProvider.of<UserCubit>(context);

  Int64? userId;

  void initId([Int64? id]) {
    userId = (id != null) ? id : userService.getUser()!.id;
  }

  Future<void> loadUser() async {
    try {
      if (state is! UserLoaded) {
        emit(UserLoading());
      }
      final user = await userService.getUserById(userId!);
      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserLoadingFailure(exception: e));
    }
  }

  Future<void> loadUserComments() async {
    try {
      if (state is! UserCommentsLoaded) {
        emit(UserLoading());
      }
      final comments = await userService.getUserComments();
      emit(UserCommentsLoaded(comments: comments));
    } catch (e) {
      emit(UserLoadingFailure(exception: e));
    }
  }

  Future<void> loadComments(Int64 userId) async {
    try {
      if (state is! CommentsLoaded) {
        emit(UserLoading());
      }
      final comments = await userService.getComments(userId);
      final user = await userService.getUserById(userId);
      emit(CommentsLoaded(comments: comments, user: user));
    } catch (e) {
      emit(UserLoadingFailure(exception: e));
    }
  }

  Future<void> logOut() async {
    await userService.logout(userId!);
  }

  Future<void> changeUser(User? user) async {
    await userService.changeUser(user);
  }

  User? getUser() => UserService().getUser();

  String? getToken() => UserService().getToken();

  Future<void> deleteUser() async {
    await userService.deleteUser();
  }
}
