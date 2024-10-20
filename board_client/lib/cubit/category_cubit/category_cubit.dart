import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data/service/category_service.dart';
import '../../generated/ad.pb.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit(this.categoryService) : super(CategoryInitial());

  static CategoryCubit get(context) => BlocProvider.of<CategoryCubit>(context);

  final CategoryService categoryService;

  Future<void> loadCategories() async {
    try {
      if (state is! CategoryLoaded) {
        emit(CategoryLoading());
      }
      final cats =  await categoryService.loadCategories();
      emit(CategoryLoaded(categories: cats.categories));
    } catch (e) {
      emit(CategoryFailure(exception: e));
    }
  }

}
