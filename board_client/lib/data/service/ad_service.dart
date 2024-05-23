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
  Future<Empty> addAd(Ad ad) async {
    _client.addAd(ChangeAdRequest(ad: ad, token: "dscscds"));
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
    final ad = await _client.getOneAd(GetByIdRequest(id: fnum.Int64(id), token: "dssss"));
    return ad;
  }

  @override
  void setFavoriteAd(fnum.Int64 id) async {
    _client.setFavoriteAd(
        SetFavoriteRequest(id: id, value: false, token: "wwwsw"));
  }

  @override
  Future<IsSuccess> deleteAd(Ad ad) async {
    return _client.deleteAd(ChangeAdRequest(ad: ad, token: "cccdc"));
  }

  @override
  Future<RepeatedAdResponse> getFavoriteAds() {
    return _client.getFavoriteAds(TokenProto(token: "cdcdcd"));
  }

  @override
  Future<RepeatedAdResponse> getMyAds() {
    return _client.getMyAds(TokenProto(token: "cdcdcd"));
  }

  @override
  Future<IsSuccess> muteAd(Ad ad) {
    return _client.muteAd(ChangeAdRequest(ad: ad, token: "cccdc"));
  }
}
