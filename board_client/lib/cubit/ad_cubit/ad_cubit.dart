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

  Future<void> loadAd({required Int64 id, required String? token}) async {
    emit(AdLoading());
    final ad = await adService.getOneAd(id, token);
    emit(AdLoaded(ad: ad));
  }

  Future<void> setFavorite(Int64 id, String? token) async {
    await adService.setFavoriteAd(id, token);
  }

  Future<void> muteAd(Int64 id, String? token) async {
    await adService.muteAd(id, token);
  }

  Future<void> deleteAd(Int64 id, String? token) async {
    await adService.deleteAd(id, token);
  }
}
