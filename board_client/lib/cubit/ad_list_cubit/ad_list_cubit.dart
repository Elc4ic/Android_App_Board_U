import 'package:bloc/bloc.dart';
import 'package:board_client/data/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/service/ad_service.dart';
import '../../generated/ad.pb.dart';

part 'ad_list_state.dart';

class AdListCubit extends Cubit<AdListState> {
  AdListCubit(this.adService) : super(AdListInitial());

  static AdListCubit get(context) => BlocProvider.of<AdListCubit>(context);

  int getPageSize() => pageSize;

  List<Ad> adList = [];

  String search = "";
  int priceMax = 0;
  int priceMin = 0;
  String address = "";
  Category? category;
  String query = "По умолчанию";
  bool isLoading = true;
  bool hasMore = true;

  int page = 0;
  static const pageSize = 10;

  final AdService adService;

  Future<void> getAdList(bool clear) async {
    try {
      if (state is! AdListLoaded) {
        emit(AdListLoading());
      }
      final ads = await adService.getManyAd(
          search, priceMax, priceMin, address, category, query, page, pageSize);
      if (clear) {
        adList.clear();
      }
      adList.addAll(ads.data);
      hasMore = ads.data.isNotEmpty;
      emit(AdListLoaded(adList: adList, hasMore: hasMore));
    } catch (e) {
      emit(AdListLoadingFailure(exception: e));
    }
  }

  void update(Ad ad) async {
    var index = adList.indexWhere((it) => it.id == ad.id);
    adList[index] = ad;
    emit(AdListLoaded(adList: adList, hasMore: hasMore));
  }

}
