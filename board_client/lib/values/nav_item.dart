part of 'values.dart';

class NavItems {
  static List<String> paths = [
    SC.MAIN_PAGE,
    SC.FAVORITE_PAGE,
    SC.AD_PAGE,
    SC.CHATS_PAGE,
    SC.SETTINGS_PAGE,
  ];

  static List<Widget> generateCaterory(List<Category> category) {
    return List.generate(
      category.length,
      (index) => CustomContainerButton(
        text: Styles.Text12(category[index].name),
        backcolor: Colors.blueAccent,
        onTap: () {},
        radius: Markup.size_12,
      ),
    ).toList();
  }
}
