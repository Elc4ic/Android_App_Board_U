part of 'ad_list_cubit.dart';

@immutable
abstract class AdListState {}

class AdListInitial extends AdListState {}

class AdListLoading extends AdListState {}

class AdListLoaded extends AdListState {
  AdListLoaded({
    required this.hasMore,
    required this.adList,
  });

  final List<Ad> adList;
  final bool hasMore;
}

class AdListLoadingFailure extends AdListState {
  AdListLoadingFailure({
    this.exception,
  });

  final Object? exception;
}
