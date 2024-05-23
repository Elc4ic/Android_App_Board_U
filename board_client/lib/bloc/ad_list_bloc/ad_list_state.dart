part of 'ad_list_bloc.dart';

@immutable
abstract class AdListState {}

class AdListInitial extends AdListState {}

class AdListLoading extends AdListState {}

class AdListLoaded extends AdListState {
  AdListLoaded({
    required this.adList,
  });

  final List<Ad> adList;
}

class AdListLoadMore extends AdListState {
  AdListLoadMore({
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
