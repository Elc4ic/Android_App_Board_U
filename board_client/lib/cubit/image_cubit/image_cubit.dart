import 'package:bloc/bloc.dart';
import 'package:board_client/data/service/ad_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:fixnum/fixnum.dart';

part 'image_state.dart';

class ImageCubit extends Cubit<ImageState> {
  Map<String, List<List<int>>> images = {};

  ImageCubit(this.adService) : super(ImageInitial());

  static ImageCubit get(context) => BlocProvider.of<ImageCubit>(context);

  final AdService adService;

  Future<void> loadImages(String adId, bool preview) async {
    emit(ImageLoading());
    if (images[adId] == null) {
      var img = await adService.loadImages(adId, preview);
      images[adId] = img;
      print(img.length);
    }
    emit(ImageLoaded(images: images));
  }
}
