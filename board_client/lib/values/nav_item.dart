part of 'values.dart';

class NavItems {
  static List<String> paths = [
    SC.MAIN_PAGE,
    SC.FAVORITE_PAGE,
    SC.AD_PAGE,
    SC.CHATS_PAGE,
    SC.SETTINGS_PAGE,
  ];

  static List<ImageProto> imagesFromFiles(List<XFile> files) {
    final webs = List<ImageProto>.empty(growable: true);
    files.forEach((it) async {
      webs.add(ImageProto(
          chunk: await imageToWebp(File(it.path).readAsBytesSync())));
    });
    return webs;
  }

  static Future<Uint8List> imageFromFile(XFile file) async {
    return imageToWebp(File(file.path).readAsBytesSync());
  }

  static Future<Uint8List> imageToWebp(Uint8List list) async {
    final result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 480,
      minWidth: 640,
      quality: 50,
      format: CompressFormat.webp,
    );
    return result;
  }

  static Future<Uint8List> avatarToWebp(Uint8List list) async {
    final result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 120,
      minWidth: 120,
      quality: 70,
      format: CompressFormat.webp,
    );
    return result;
  }
}
