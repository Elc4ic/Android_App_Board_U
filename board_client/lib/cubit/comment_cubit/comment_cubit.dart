import 'package:bloc/bloc.dart';
import 'package:board_client/cubit/user_cubit/user_cubit.dart';
import 'package:board_client/data/service/user_service.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:fixnum/fixnum.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  CommentCubit(this.userService) : super(CommentInitial());

  final UserService userService;

  static CommentCubit get(context) => BlocProvider.of<CommentCubit>(context);

  Future<void> loadUserComments() async {
    try {
      if (state is! UserCommentsLoaded) {
        emit(CommentLoading());
      }
      final comments = await userService.getUserComments();
      emit(UserCommentsLoaded(comments: comments));
    } catch (e) {
      emit(CommentLoadingFailure(exception: e));
    }
  }

  Future<void> loadComments(Int64 userId) async {
    try {
      if (state is! CommentsLoaded) {
        emit(CommentLoading());
      }
      final comments = await userService.getComments(userId);
      final user = await userService.getUserById(userId);
      emit(CommentsLoaded(comments: comments, user: user));
    } catch (e) {
      emit(CommentLoadingFailure(exception: e));
    }
  }

  User? getUser() => UserService().getUser();
}
