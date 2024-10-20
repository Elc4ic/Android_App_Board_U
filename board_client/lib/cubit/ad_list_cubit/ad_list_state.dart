part of 'ad_list_cubit.dart';

@immutable
abstract class AdListState {}

class AdListInitial extends AdListState {}

class AdListLoading extends AdListState {}

class MyAdListLoading extends AdListState {}

class FavAdListLoading extends AdListState {}

class AdListLoaded extends AdListState {
  AdListLoaded({
    required this.hasMore,
    required this.adList,
  });

  final List<Ad> adList;
  final bool hasMore;
}

class MyAdListLoaded extends AdListState {
  MyAdListLoaded({
    required this.adList,
  });

  final List<Ad> adList;
}

class FavAdListLoaded extends AdListState {
  FavAdListLoaded({
    required this.adList,
  });

  final List<Ad> adList;
}

class AdListLoadingFailure extends AdListState {
  AdListLoadingFailure({
    this.exception,
  });

  final Object? exception;
}
