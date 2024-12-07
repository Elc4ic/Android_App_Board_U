import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../generated/ad.pb.dart';

part 'fav_state.dart';

class FavCubit extends Cubit<FavState> {
  FavCubit(this.adService) : super(FavInitial());

  static FavCubit get(context) => BlocProvider.of<FavCubit>(context);

  AdService adService;
  List<Ad> favs = [];

  void addFav(Ad ad) async {
    favs.add(ad);
    emit(FavLoaded(favs: favs));
  }

  void removeFav(Ad ad) {
    favs.removeWhere((item) => item.id == ad.id);
  }

  fetchFavsHistory() async {
    favs.clear();
    try {
      if (state is! FavLoaded) {
        emit(FavLoading());
      }
      final res = await adService.getFavoriteAds();
      favs.addAll(res.data);
      emit(FavLoaded(favs: favs));
    } catch (e) {
      emit(FavLoadingFailure(exception: e));
    }
  }
}
