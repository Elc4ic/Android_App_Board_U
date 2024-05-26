import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:board_client/data/repository/category_repository.dart';
import 'package:meta/meta.dart';

import '../../generated/ad.pb.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc(this.categoryRepository) : super(CategoryListInitial()) {
    on<LoadCategories>(_load);
    on<LoadAdInCategory>(_loadAd);
  }

  final CategoryRepository categoryRepository;

  Future<void> _load(
      LoadCategories event,
      Emitter<CategoryListState> emit,
      ) async {
    try {
      if (state is! CategoryListLoaded) {
        emit(CategoryLoading());
      }
      final cats =  await categoryRepository.loadCategories();
      emit(CategoryListLoaded(categories: cats.categories));
    } catch (e) {
      emit(CategoryFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }

  Future<void> _loadAd(
      LoadAdInCategory event,
      Emitter<CategoryListState> emit,
      ) async {
    try {
      if (state is! CategoryListLoaded) {
        emit(CategoryLoading());
      }
      final cats =  await categoryRepository.getCategory(event.category.id);
      emit(AdInCategoryLoaded(ads: cats.data));
    } catch (e) {
      emit(CategoryFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}
