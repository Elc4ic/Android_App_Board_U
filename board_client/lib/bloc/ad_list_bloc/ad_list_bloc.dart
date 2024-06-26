import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/repository/ad_repository.dart';
import '../../../../generated/ad.pb.dart';
import '../../data/repository/user_repository.dart';

part 'ad_list_event.dart';

part 'ad_list_state.dart';

class AdListBloc extends Bloc<AdListEvent, AdListState> {
  List<Ad> adList = [];

  AdListBloc(this.adRepository, this.userRepository) : super(AdListInitial()) {
    on<LoadAdList>(_loadPage);
    on<LoadMyAd>(_load_my);
    on<LoadFavAd>(_load_fav);
  }

  final AdRepository adRepository;
  final UserRepository userRepository;

  Future<void> _loadPage(
    LoadAdList event,
    Emitter<AdListState> emit,
  ) async {
    try {
      if (state is! AdListLoaded) {
        emit(AdListLoading());
      }
      final ads = await adRepository.getManyAd(
          "search", event.page, event.pageSize, userRepository.getToken());
      if (event.clear) {
        adList.clear();
      }
      adList = adList + ads.data;
      emit(AdListLoaded(adList: adList));
    } catch (e) {
      emit(AdListLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _load_my(
    LoadMyAd event,
    Emitter<AdListState> emit,
  ) async {
    try {
      if (state is! AdListLoaded) {
        emit(AdListLoading());
      }
      final ads = await adRepository.getMyAds(userRepository.getToken());
      emit(AdListLoaded(adList: ads.data));
    } catch (e) {
      emit(AdListLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _load_fav(
    LoadFavAd event,
    Emitter<AdListState> emit,
  ) async {
    try {
      if (state is! AdListLoaded) {
        emit(AdListLoading());
      }
      final ads = await adRepository.getFavoriteAds(userRepository.getToken());
      emit(AdListLoaded(adList: ads.data));
    } catch (e) {
      emit(AdListLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
  }
}
