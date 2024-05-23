part of 'ad_list_bloc.dart';

@immutable
abstract class AdListEvent {}

class LoadAdList extends AdListEvent {
  LoadAdList(
    this.search, {
    this.completer,
  });

  final String search;
  final Completer? completer;
}

class LoadMyAd extends AdListEvent {
  LoadMyAd({
    this.completer,
  });

  final Completer? completer;
}

class LoadFavAd extends AdListEvent {
  LoadFavAd({
    this.completer,
  });

  final Completer? completer;
}
