
import '../../generated/ad.pb.dart';
import 'package:fixnum/fixnum.dart';

abstract class CategoryRepository {
   Future<GetAllCategoriesResponse> loadCategories();
   List<Category>? getCategories();
}