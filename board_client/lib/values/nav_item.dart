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
}
