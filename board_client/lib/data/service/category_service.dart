import 'package:board_client/generated/user.pb.dart';
import 'package:grpc/grpc.dart';

import '../../generated/ad.pbgrpc.dart';
import '../../values/values.dart';

class CategoryService {
  static List<Category>? categories;
  late CategoryAPIClient _client;

  void initClient(String? token) {
    final channel = ClientChannel(
      Const.HOST,
      port: Const.PORT,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _client = CategoryAPIClient(channel,
        options: CallOptions(metadata: {'token': token ?? ""}));
  }

  Future<GetAllCategoriesResponse> loadCategories() async {
    var response = await _client.getAllCategories(Empty());
    categories = response.categories;
    return response;
  }

  List<Category>? getCategories() => categories;
}
