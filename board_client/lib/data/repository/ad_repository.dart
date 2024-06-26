import 'package:fixnum/fixnum.dart';
import 'package:board_client/generated/ad.pb.dart';

import '../../generated/user.pb.dart';

abstract class AdRepository {
  Future<PaginatedAd> getManyAd(String search,int page,int pageSize, String? token);

  Future<Ad> getOneAd(int id,String? token);

  Future<bool> setFavoriteAd(Int64 id, String? token);

  Future<Empty> addAd(Ad ad, String? token);

  Future<IsSuccess> deleteAd(Ad ad, String? token);

  Future<IsSuccess> muteAd(Ad ad, String? token);

  Future<RepeatedAdResponse> getFavoriteAds(String? token);

  Future<RepeatedAdResponse> getMyAds(String? token);
}
