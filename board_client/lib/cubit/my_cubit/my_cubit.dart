import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/service/ad_service.dart';
import '../../generated/ad.pb.dart';

part 'my_state.dart';

class MyCubit extends Cubit<MyState> {
  MyCubit(this.adService) : super(MyInitial());

  static MyCubit get(context) => BlocProvider.of<MyCubit>(context);
  final AdService adService;
  List<Ad> myList = [];

  Future<void> getMyList() async {
    try {
      if (state is! MyLoaded) {
        emit(MyLoading());
      }
      final ads = await adService.getMyAds();
      myList = ads.data;
      emit(MyLoaded(myAds: myList));
    } catch (e) {
      emit(MyLoadingFailure(exception: e));
    }
  }

  Future<void> update(Ad ad) async {
    var index = myList.indexWhere((it) => it.id == ad.id);
    myList[index] = ad;
    emit(MyLoaded(myAds: myList));
  }

  void mute(Ad ad) async {
    var response = await adService.muteAd(ad.id);
    if (!response.login) return;
    var index = myList.indexWhere((it) => it.id == ad.id);
    ad.isActive = !ad.isActive;
    myList[index] = ad;
    emit(MyLoaded(myAds: myList));
  }

  void remove(Ad ad) async {
    var response = await adService.deleteAd(ad.id);
    if (!response.login) return;
    myList.removeWhere((it) => it.id == ad.id);
    emit(MyLoaded(myAds: myList));
  }
}
