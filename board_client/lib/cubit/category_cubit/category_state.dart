part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  CategoryLoaded({
    required this.categories,
  });
  final List<Category> categories;
}

class CategoryFailure extends CategoryState {
  CategoryFailure({
    this.exception,
  });

  final Object? exception;
}
