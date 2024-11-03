import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:fixnum/fixnum.dart';

import '../../data/service/ad_service.dart';
import '../../generated/ad.pb.dart';

part 'ad_state.dart';

class AdCubit extends Cubit<AdState> {
  AdCubit(this.adService) : super(AdInitial());

  final AdService adService;

  static AdCubit get(context) => BlocProvider.of<AdCubit>(context);

  Future<void> loadAd({required String id}) async {
    emit(AdLoading());
    final ad = await adService.getOneAd(id);
    emit(AdLoaded(ad: ad));
  }

  Future<void> setFavorite(String id) async {
    await adService.setFavoriteAd(id);
  }

  Future<void> muteAd(String id) async {
    await adService.muteAd(id);
  }

  Future<void> deleteAd(String id) async {
    await adService.deleteAd(id);
  }
}
