import 'package:bloc/bloc.dart';
import 'package:board_client/data/service/cache_service.dart';
import 'package:board_client/data/service/session_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/service/ad_service.dart';
import '../../generated/ad.pb.dart';

part 'ad_state.dart';

class AdCubit extends Cubit<AdState> {
  AdCubit(this.adService, this.sessionService) : super(AdInitial());

  final AdService adService;
  final SessionService sessionService;

  static AdCubit get(context) => BlocProvider.of<AdCubit>(context);

  Future<void> loadAd({required String id}) async {
    emit(AdLoading());
    final ad = await adService.getOneAd(id);
    sessionService.addSubscribeUser(ad.user.id);
    CacheService.putBoolean(key: ad.id, value: true);
    var online = sessionService.isOnline(ad.user.id);
    emit(AdLoaded(
      ad: ad,
      online: online,
    ));
  }
}
