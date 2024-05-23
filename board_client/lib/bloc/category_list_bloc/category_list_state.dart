part of 'category_list_bloc.dart';

@immutable
abstract class CategoryListState {}

class CategoryListInitial extends CategoryListState {}

class CategoryListLoading extends CategoryListState {}

class CategoryListLoaded extends CategoryListState {
  CategoryListLoaded({
    required this.categories,
  });
  final List<Category> categories;
}

class CategoryListLoadingFailure extends CategoryListState {
  CategoryListLoadingFailure({
    this.exception,
  });

  final Object? exception;
}
