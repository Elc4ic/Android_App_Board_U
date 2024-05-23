import 'package:board_client/data/repository/category_repository.dart';
import 'package:fixnum/fixnum.dart' as fnum;
import 'package:grpc/grpc.dart';

import '../../generated/ad.pbgrpc.dart';
import '../../values/values.dart';

class CategoryService implements CategoryRepository {
  static List<Category>? categories;
  late CategoryAPIClient _client;
  final pageSize = 10;

  CategoryService() {
    final channel = ClientChannel(
      Const.HOST,
      port: Const.PORT,
      options: const ChannelOptions(
        credentials: ChannelCredentials.insecure(),
      ),
    );
    _client = CategoryAPIClient(channel);
  }

  @override
  Future<GetAllCategoriesResponse> loadCategories() async {
    var response = await _client.getAllCategories(Empty());
    categories = response.categories;
    return response;
  }

  @override
  Future<RepeatedAdResponse> getCategory(fnum.Int64 id) {
    var request = GetByIdRequest(id: id, token: "cccscs");
    return _client.getCategory(request);
  }

  @override
  List<Category>? getCategories() => categories;
}
