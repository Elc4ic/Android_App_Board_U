part of 'ad_list_bloc.dart';

@immutable
abstract class AdListEvent {}

class LoadAdList extends AdListEvent {
  LoadAdList(
    this.search,
    this.address,
    this.priceMax,
    this.priceMin,
    this.page,
    this.pageSize,
    this.clear,
    this.category,
    this.query, {
    this.completer,
  });

  final String search;
  final String address;
  final String query;
  final int page;
  final int priceMax;
  final int priceMin;
  final Category? category;
  final int pageSize;
  final bool clear;
  final Completer? completer;
}

class LoadMyAd extends AdListEvent {
  LoadMyAd({
    this.completer,
  });

  final Completer? completer;
}

class LoadUserAd extends AdListEvent {
  LoadUserAd(
    this.id, {
    this.completer,
  });

  final Int64 id;
  final Completer? completer;
}

class LoadFavAd extends AdListEvent {
  LoadFavAd({
    this.completer,
  });

  final Completer? completer;
}
