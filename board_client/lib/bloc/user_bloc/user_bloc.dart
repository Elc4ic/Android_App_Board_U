import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:board_client/generated/user.pb.dart';
import 'package:meta/meta.dart';
import 'package:fixnum/fixnum.dart';

import '../../data/repository/user_repository.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(this.userRepository) : super(UserInitial()) {
    on<LoadUser>(_load);
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
}
