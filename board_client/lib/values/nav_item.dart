part of 'values.dart';

class NavItems {
  static List<String> paths = [
    SC.MAIN_PAGE,
    SC.FAVORITE_PAGE,
    SC.AD_PAGE,
    SC.CHATS_PAGE,
    SC.SETTINGS_PAGE,
  ];

  static List<Widget> generateCategory(
      List<Category> category, BuildContext context) {
    return List.generate(
      category.length,
      (index) => CustomContainerButton(
        text: Styles.Text12(category[index].name),
        backcolor: Colors.blueAccent,
        onTap: () {
          context.push("${SC.MAIN_PAGE}/$index");
        },
        radius: Markup.size_12,
      ),
    ).toList();
  }

  static List<Widget> wrapFiles(List<XFile> files) {
    return List.generate(
      files.length,
      (index) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Markup.size_12),
            border: Border.all(width: 2)),
        padding: Markup.padding_all_4,
        child: Styles.Text12(files[index].name),
      ),
    ).toList();
  }

  static void resetAllBranches(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  static List<ImageProto> imageFromFilePicker(List<XFile> files) {
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
      quality: 40,
      format: CompressFormat.webp,
    );
    return result;
  }
  static Future<Uint8List> avatarToWebp(Uint8List list) async {
    final result = await FlutterImageCompress.compressWithList(
      list,
      minHeight: 100,
      minWidth: 100,
      quality: 10,
      format: CompressFormat.webp,
    );
    return result;
  }
}
