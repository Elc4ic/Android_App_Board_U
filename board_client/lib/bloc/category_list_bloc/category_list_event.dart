part of 'category_list_bloc.dart';

@immutable
abstract class CategoryListEvent {}

class LoadCategories extends CategoryListEvent {
  LoadCategories({
    this.completer,
  });

  final Completer? completer;
}
