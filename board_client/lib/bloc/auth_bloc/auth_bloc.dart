import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:board_client/data/repository/user_repository.dart';
import 'package:meta/meta.dart';

import '../../generated/user.pb.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.userRepository) : super(AuthInitial()) {
    on<LoginEvent>(_login);
    on<SignInEvent>(_signin);
  }

  final UserRepository userRepository;

  Future<void> _login(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state is! LoginSuccess) {
        emit(Loading());
      }
      await userRepository.login(event.username, event.password);
      emit(LoginSuccess());
    } catch (e) {
      emit(Failure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _signin(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      if (state is! SingInSuccess) {
        emit(Loading());
      }
      await userRepository.signUp(
          event.username, event.password, event.phone);
      emit(SingInSuccess());
    } catch (e) {
      emit(Failure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}
