part of 'fav_cubit.dart';

@immutable
sealed class FavState {}

final class FavInitial extends FavState {}

class FavLoading extends FavState {}

class FavLoaded extends FavState {
  FavLoaded({required this.favs});
  final List<Ad> favs;
}

class FavLoadingFailure extends FavState {
  FavLoadingFailure({this.exception});
  final Object? exception;
}
