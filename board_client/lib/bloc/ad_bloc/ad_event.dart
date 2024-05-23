part of 'ad_bloc.dart';

@immutable
abstract class AdEvent {}

class LoadAd extends AdEvent {
  LoadAd({required this.id,
  });
  final int id;
}
