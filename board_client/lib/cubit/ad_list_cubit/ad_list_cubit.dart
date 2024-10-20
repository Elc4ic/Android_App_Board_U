import 'package:bloc/bloc.dart';
import 'package:board_client/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:fixnum/fixnum.dart';

import '../../data/service/ad_service.dart';
import '../../generated/ad.pb.dart';

part 'ad_list_state.dart';

class AdListCubit extends Cubit<AdListState> {
  AdListCubit(this.adService, this.userService) : super(AdListInitial());

  static AdListCubit get(context) => BlocProvider.of<AdListCubit>(context);

  List<Ad> adList = [];

  String search = "";
  int priceMax = 0;
  int priceMin = 0;
  String address = "";
  Category? category;
  String query = "По умолчанию";
  bool isLoading = true;

  int page = 0;
  static const pageSize = 10;

  final AdService adService;
  final UserService userService;

  Future<void> getAdList(bool clear) async {
    try {
      if (state is! AdListLoaded) {
        emit(AdListLoading());
      }
      final ads = await adService.getManyAd(search, priceMax, priceMin, address,
          category, query, page, pageSize, userService.getToken());
      if (clear) {
        adList.clear();
      }
      adList = [...adList, ...ads.data];
      emit(AdListLoaded(adList: adList, hasMore: ads.data.isNotEmpty));
    } catch (e) {
      emit(AdListLoadingFailure(exception: e));
    }
  }

  Future<void> getMyList() async {
    try {
      if (state is! AdListLoaded) {
        emit(AdListLoading());
      }
      final ads = await adService.getMyAds(userService.getToken());
      print(ads.data.toString());
      emit(AdListLoaded(adList: ads.data, hasMore: false));
    } catch (e) {
      emit(AdListLoadingFailure(exception: e));
    }
  }

  Future<void> getFavList() async {
    try {
      if (state is! AdListLoaded) {
        emit(AdListLoading());
      }
      final ads = await adService.getFavoriteAds(userService.getToken());

      emit(AdListLoaded(adList: ads.data, hasMore: false));
    } catch (e) {
      emit(AdListLoadingFailure(exception: e));
    }
  }

  Future<void> getUserList(Int64 id) async{
    try {
      if (state is! AdListLoaded) {
        emit(AdListLoading());
      }
      final ads = await adService.getByUserId(id);
      emit(AdListLoaded(adList: ads.data, hasMore: false));
    } catch (e) {
      emit(AdListLoadingFailure(exception: e));
    }
  }
}
