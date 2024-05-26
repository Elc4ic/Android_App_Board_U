part of 'values.dart';

class NavItems {
  static List<String> paths = [
    SC.MAIN_PAGE,
    SC.FAVORITE_PAGE,
    SC.AD_PAGE,
    SC.CHATS_PAGE,
    SC.SETTINGS_PAGE,
  ];

  static List<Widget> generateCategory(List<Category> category,BuildContext context) {
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
}
