import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:fixnum/fixnum.dart';

import '../../data/repository/ad_repository.dart';
import '../../generated/ad.pb.dart';

part 'ad_event.dart';

part 'ad_state.dart';

class AdBloc extends Bloc<AdEvent, AdState> {
  AdBloc(this.adRepository) : super(AdInitial()) {
    on<LoadAd>(_load);
  }

  final AdRepository adRepository;

  Future<void> _load(
    LoadAd event,
    Emitter<AdState> emit,
  ) async {
    try {
      if (state is! AdLoaded) {
        emit(AdLoading());
      }
      final ad = await adRepository.getOneAd(event.id, event.token);
      emit(AdLoaded(ad: ad));
    } catch (e) {
      emit(AdLoadingFailure(exception: e));
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}
