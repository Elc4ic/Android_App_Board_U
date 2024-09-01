import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:meta/meta.dart';
import 'package:fixnum/fixnum.dart';

import '../../data/repository/user_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.userRepository) : super(UserInitial()) {
    on<LoadUser>(_load);
    on<LoadUserComments>(_load_user_comments);
    on<LoadComments>(_load_comments);
  }

  final UserRepository userRepository;

  Future<void> _load(
    LoadUser event,
    Emitter<UserState> emit,
  ) async {
    try {
      if (state is! UserLoaded) {
        emit(UserLoading());
      }
      final user = await userRepository.getUserById(event.userId);
      emit(UserLoaded(user: user));
    } catch (e) {
      emit(UserLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _load_user_comments(
    LoadUserComments event,
    Emitter<UserState> emit,
  ) async {
    try {
      if (state is! UserCommentsLoaded) {
        emit(UserLoading());
      }
      final comments =
          await userRepository.getUserComments();
      emit(UserCommentsLoaded(comments: comments));
    } catch (e) {
      emit(UserLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _load_comments(
    LoadComments event,
    Emitter<UserState> emit,
  ) async {
    try {
      if (state is! CommentsLoaded) {
        emit(UserLoading());
      }
      final comments = await userRepository.getComments(event.userId);
      final user = await userRepository.getUserById(event.userId);
      emit(CommentsLoaded(comments: comments,user: user));
    } catch (e) {
      emit(UserLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}
