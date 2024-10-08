part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class LoadImageList extends ImageEvent {
  LoadImageList(
    this.adId,
    this.preview, {
    this.completer,
  });

  final Int64 adId;
  final bool preview;
  final Completer? completer;
}
