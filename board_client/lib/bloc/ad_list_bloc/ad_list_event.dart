part of 'ad_list_bloc.dart';

@immutable
abstract class AdListEvent {}

class LoadAdList extends AdListEvent {
  LoadAdList(
    this.search, this.page, this.pageSize, this.clear, {
    this.completer,
  });

  final String search;
  final int page;
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
  LoadUserAd(this.id, {
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
