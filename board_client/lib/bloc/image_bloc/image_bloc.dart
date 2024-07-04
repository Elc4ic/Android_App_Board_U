import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:fixnum/fixnum.dart';

import '../../data/repository/ad_repository.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImageState> {
  ImageBloc(this.adRepository) : super(ImageInitial()) {
    on<LoadImageList>(_load);
  }

  final AdRepository adRepository;

  Future<void> _load(
    LoadImageList event,
    Emitter<ImageState> emit,
  ) async {
    try {
      if (state is! ImageLoaded) {
        emit(ImageLoading());
      }
      final images =
          await adRepository.loadImages(event.adId, event.token, event.preview);
      emit(ImageLoaded(images: images));
    } catch (e) {
      emit(ImageLoadingFailure(exception: e));
    } finally {
      event.completer?.complete();
    }
  }
}
