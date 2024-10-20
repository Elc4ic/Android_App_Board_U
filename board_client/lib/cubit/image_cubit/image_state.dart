part of 'image_cubit.dart';

@immutable
abstract class ImageState {}

class ImageInitial extends ImageState {}

class ImageLoading extends ImageState {}

class ImageLoaded extends ImageState {
  ImageLoaded({
    required this.images,
  });

  final Map<Int64,List<List<int>>> images;
}

class ImageLoadingFailure extends ImageState {
  ImageLoadingFailure({
    this.exception,
  });

  final Object? exception;
}