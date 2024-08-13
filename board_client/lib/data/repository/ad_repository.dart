import 'package:fixnum/fixnum.dart';
import 'package:board_client/generated/ad.pb.dart';

import '../../generated/image.pb.dart';
import '../../generated/user.pb.dart';

abstract class AdRepository {
  Future<PaginatedAd> getManyAd(String search, int priceMax, int priceMin,
      String address,Category? category, int page, int pageSize, String? token);

  Future<Ad> getOneAd(Int64 id, String? token);

  Future<bool> setFavoriteAd(Int64 id, String? token);

  Future<Empty> addAd(Ad ad, List<ImageProto> images, String? token);

  Future<IsSuccess> deleteAd(Int64 id, String? token);

  Future<IsSuccess> muteAd(Int64 id, String? token);

  Future<RepeatedAdResponse> getFavoriteAds(String? token);

  Future<RepeatedAdResponse> getMyAds(String? token);

  Future<RepeatedAdResponse> getByUserId(Int64 id);

  Future<List<List<int>>> loadImages(Int64 id, String? token, bool preview);
}
