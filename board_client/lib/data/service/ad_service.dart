import 'package:board_client/generated/user.pb.dart';
import 'package:fixnum/fixnum.dart' as fnum;
import 'package:board_client/data/repository/ad_repository.dart';
import 'package:board_client/generated/ad.pbgrpc.dart';
import 'package:grpc/grpc.dart';

import '../../values/values.dart';

class AdService implements AdRepository {
  late AdAPIClient _client;
  final pageSize = 10;

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
  Future<Empty> addAd(Ad ad,String? token) async {
    _client.addAd(ChangeAdRequest(ad: ad, token: token));
    return Empty();
  }

  @override
  Future<PaginatedAd> getManyAd(String search) async {
    final response = _client.getManyAd(
      GetManyAdRequest(
          query: search,
          limit: fnum.Int64(pageSize),
          page: fnum.Int64(0),
          token: "cscscs"),
    );
    return response;
  }

  @override
  Future<Ad> getOneAd(int id) async {
    final ad = await _client.getOneAd(GetByIdRequest(id: fnum.Int64(id), token: "empty_token"));
    return ad;
  }

  @override
  void setFavoriteAd(fnum.Int64 id,String? token) async {
    _client.setFavoriteAd(
        SetFavoriteRequest(id: id, value: false, token: token));
  }

  @override
  Future<IsSuccess> deleteAd(Ad ad,String? token) async {
    return await _client.deleteAd(ChangeAdRequest(ad: ad, token: token));
  }

  @override
  Future<RepeatedAdResponse> getFavoriteAds(String? token) async {
    return await  _client.getFavoriteAds(JwtProto(token: token));
  }

  @override
  Future<RepeatedAdResponse> getMyAds(String? token) async {
    return await _client.getMyAds(JwtProto(token: token));
  }

  @override
  Future<IsSuccess> muteAd(Ad ad,String? token) async {
    return await _client.muteAd(ChangeAdRequest(ad: ad, token: token));
  }
}
