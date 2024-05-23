import 'package:fixnum/fixnum.dart';
import 'package:board_client/generated/ad.pb.dart';

import '../../generated/user.pb.dart';

abstract class AdRepository {
  Future<PaginatedAd> getManyAd(String search);

  Future<Ad> getOneAd(int id);

  void setFavoriteAd(Int64 id);

  Future<Empty> addAd(Ad ad);

  Future<IsSuccess> deleteAd(Ad ad);

  Future<IsSuccess> muteAd(Ad ad);

  Future<RepeatedAdResponse> getFavoriteAds();

  Future<RepeatedAdResponse> getMyAds();
}
