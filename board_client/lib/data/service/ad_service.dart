import 'package:board_client/generated/user.pb.dart';
import 'package:fixnum/fixnum.dart' as fnum;
import 'package:board_client/data/repository/ad_repository.dart';
import 'package:board_client/generated/ad.pbgrpc.dart';
import 'package:grpc/grpc.dart';

import '../../generated/image.pb.dart';
import '../../values/values.dart';

class AdService implements AdRepository {
  late AdAPIClient _client;

  AdService() {
    final channel = ClientChannel(
      Const.HOST,
      port: Const.PORT,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _client = AdAPIClient(channel);
  }

  @override
  Future<Empty> addAd(Ad ad, List<ImageProto> images, String? token) async {
    _client.addAd(ChangeAdRequest(ad: ad, images: images, token: token));
    return Empty();
  }

  @override
  Future<PaginatedAd> getManyAd(
      String search,
      int priceMax,
      int priceMin,
      String address,
      Category? category,
      String query,
      int page,
      int pageSize,
      String? token) async {
    final response = _client.getManyAd(
      GetManyAdRequest(
          filter: FilterQuery(
              search: search,
              priceMax: fnum.Int64(priceMax),
              priceMin: fnum.Int64(priceMin),
              address: address,
              category: category,
              query: query),
          limit: fnum.Int64(pageSize),
          page: fnum.Int64(page),
          token: token),
    );
    return response;
  }

  @override
  Future<Ad> getOneAd(fnum.Int64 id, String? token) async {
    final ad = await _client.getOneAd(GetByIdRequest(id: id, token: token));
    return ad;
  }

  @override
  Future<bool> setFavoriteAd(fnum.Int64 id, String? token) async {
    var response =
        await _client.setFavoriteAd(GetByIdRequest(id: id, token: token));
    return response.login;
  }

  @override
  Future<IsSuccess> deleteAd(fnum.Int64 id, String? token) async {
    return await _client.deleteAd(GetByIdRequest(id: id, token: token));
  }

  @override
  Future<RepeatedAdResponse> getFavoriteAds(String? token) async {
    return await _client.getFavoriteAds(JwtProto(token: token));
  }

  @override
  Future<RepeatedAdResponse> getMyAds(String? token) async {
    return await _client.getMyAds(JwtProto(token: token));
  }

  @override
  Future<RepeatedAdResponse> getByUserId(fnum.Int64 id) {
    return _client.getByUserId(GetByIdRequest(id: id, token: "empty"));
  }

  @override
  Future<IsSuccess> muteAd(fnum.Int64 id, String? token) async {
    return await _client.muteAd(GetByIdRequest(id: id, token: token));
  }

  @override
  Future<List<List<int>>> loadImages(
      fnum.Int64 id, String? token, bool preview) async {
    final res = await _client.loadImage(
        GetByIdWithBoolRequest(id: id, token: token, value: preview));
    final resList = <List<int>>[];
    for (final image in res.data) {
      resList.add(image.chunk);
    }
    return resList;
  }
}
