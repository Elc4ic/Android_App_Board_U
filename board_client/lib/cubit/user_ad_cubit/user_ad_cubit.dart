import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/service/ad_service.dart';
import '../../generated/ad.pb.dart';

part 'user_ad_state.dart';

class UserAdCubit extends Cubit<UserAdState> {
  UserAdCubit(this.adService) : super(UserAdInitial());

  static UserAdCubit get(context) => BlocProvider.of<UserAdCubit>(context);

  final AdService adService;
  List<Ad> userList = [];

  Future<void> getUserList(String id) async {
    try {
      if (state is! UserAdLoaded) {
        emit(UserAdLoading());
      }
      final ads = await adService.getByUserId(id);
      userList = ads.data;
      emit(UserAdLoaded(userAds: userList));
    } catch (e) {
      emit(UserAdLoadingFailure(exception: e));
    }
  }
}
