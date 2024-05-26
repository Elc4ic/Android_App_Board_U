part of 'category_list_bloc.dart';

@immutable
abstract class CategoryListState {}

class CategoryListInitial extends CategoryListState {}

class CategoryLoading extends CategoryListState {}

class CategoryListLoaded extends CategoryListState {
  CategoryListLoaded({
    required this.categories,
  });
  final List<Category> categories;
}

class AdInCategoryLoaded extends CategoryListState {
  AdInCategoryLoaded({
    required this.ads,
  });
  final List<Ad> ads;
}

class CategoryFailure extends CategoryListState {
  CategoryFailure({
    this.exception,
  });

  final Object? exception;
}
