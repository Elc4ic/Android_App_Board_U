import 'package:board_client/generated/user.pb.dart';
import 'package:fixnum/fixnum.dart' as fnum;
import 'package:board_client/generated/ad.pbgrpc.dart';
import 'package:grpc/grpc.dart';

import '../../generated/image.pb.dart';
import '../../values/values.dart';

class AdService {
  late AdAPIClient _client;

  void initClient(String? token) {
    final channel = ClientChannel(
      Const.HOST,
      port: Const.PORT,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _client = AdAPIClient(
      channel,
      options: CallOptions(metadata: {'token': token ?? ""}),
    );
  }

  Future<Empty> addAd(Ad ad, List<ImageProto> images) async {
    _client.addAd(ChangeAdRequest(ad: ad, images: images));
    return Empty();
  }

  Future<PaginatedAd> getManyAd(
      String search,
      int priceMax,
      int priceMin,
      String address,
      Category? category,
      String query,
      int page,
      int pageSize) async {
    final response = _client.getManyAd(
      GetManyAdRequest(
        filter: FilterQuery(
            search: search,
            priceMax: fnum.Int64(priceMax),
            priceMin: fnum.Int64(priceMin),
            address: address,
            category: category,
            query: query),
        limit: pageSize,
        page: page,
      ),
    );
    return response;
  }

  Future<Ad> getOneAd(fnum.Int64 id) async {
    final ad = await _client.getOneAd(GetByIdRequest(id: id));
    return ad;
  }

  Future<bool> setFavoriteAd(fnum.Int64 id) async {
    var response = await _client.setFavoriteAd(GetByIdRequest(id: id));
    return response.login;
  }

  Future<IsSuccess> deleteAd(fnum.Int64 id) async {
    return await _client.deleteAd(GetByIdRequest(id: id));
  }

  Future<RepeatedAdResponse> getFavoriteAds() async {
    return await _client.getFavoriteAds(Empty());
  }

  Future<RepeatedAdResponse> getMyAds() async {
    return await _client.getMyAds(Empty());
  }

  Future<RepeatedAdResponse> getByUserId(fnum.Int64 id) {
    return _client.getByUserId(GetByIdRequest(id: id));
  }

  Future<IsSuccess> muteAd(fnum.Int64 id) async {
    return await _client.muteAd(GetByIdRequest(id: id));
  }

  Future<List<List<int>>> loadImages(fnum.Int64 id, bool preview) async {
    final res =
        await _client.loadImage(GetByIdWithBoolRequest(id: id, value: preview));
    final resList = <List<int>>[];
    for (final image in res.data) {
      print(image.chunk.length);
      resList.add(image.chunk);
    }
    return resList;
  }
}
