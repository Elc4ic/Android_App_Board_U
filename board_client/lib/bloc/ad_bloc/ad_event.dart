part of 'ad_bloc.dart';

@immutable
abstract class AdEvent {}

class LoadAd extends AdEvent {
  LoadAd({
    required this.id,
    this.token,
  });

  final fnum.Int64 id;
  final String? token;
}
