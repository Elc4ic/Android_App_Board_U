part of 'values.dart';

class Markup {
  //sizes
  static const double size_10 = 10.0;
  static const double size_12 = 12.0;
  static const double size_14 = 14.0;
  static const double size_16 = 16.0;
  static const double size_20 = 20.0;
  static const double size_24 = 24.0;
  static const double size_32 = 32.0;

  //padding
  static const EdgeInsets padding_all_16 = EdgeInsets.all(16);
  static const EdgeInsets padding_all_12 = EdgeInsets.all(12);
  static const EdgeInsets padding_all_8 = EdgeInsets.all(8);
  static const EdgeInsets padding_all_4 = EdgeInsets.all(4);
  static const EdgeInsets padding_all_2 = EdgeInsets.all(2);

  static const EdgeInsets padding_t_4 = EdgeInsets.only(top: 4);

  static const EdgeInsets padding_avatar = EdgeInsets.only(top: 32, bottom: 4);
  static const EdgeInsets padding_setting = EdgeInsets.only(top: 100);

  static const EdgeInsets padding_t_l_8 = EdgeInsets.only(left: 8, top: 8);
  static const EdgeInsets padding_h_24_t_16_b_4 =
      EdgeInsets.only(left: 12, right: 12, top: 24, bottom: 4);
  static const EdgeInsets padding_h_16_t_4_b_16 =
      EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 16);
  static const EdgeInsets padding_l_16_t_24_b_2 =
      EdgeInsets.only(left: 16, top: 24, bottom: 2);
  static const EdgeInsets padding_h_8_t_12_b_2 =
      EdgeInsets.only(left: 4, right: 4, top: 12, bottom: 2);
  static const EdgeInsets padding_h_16_v_4 =
      EdgeInsets.symmetric(vertical: 4, horizontal: 16);
  static const EdgeInsets padding_h_8_v_4 =
      EdgeInsets.symmetric(vertical: 4, horizontal: 8);
  static const EdgeInsets padding_h_8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets padding_h8_v16 =
      EdgeInsets.symmetric(horizontal: 8, vertical: 16);
  static const EdgeInsets padding_h_4 = EdgeInsets.symmetric(horizontal: 4);
  static const EdgeInsets padding_v_8 = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets padding_v_4 = EdgeInsets.symmetric(vertical: 4);

  //cliper
  static const BorderRadius clip_t_20 = BorderRadius.only(
      topLeft: Radius.circular(20), topRight: Radius.circular(20));

  static BoxDecoration clip_container_10 = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
  );

  //dividers
  static const Widget dividerH5 = SizedBox(height: 5);
  static const Widget dividerH10 = SizedBox(height: 10);
  static const Widget dividerW5 = SizedBox(width: 5);
  static const Widget dividerW10 = SizedBox(width: 10);

  static double widthNow(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static String capitalize(String? str) {
    if (str == null || str == "") return "";
    return "${str[0].toUpperCase()}${str.substring(1)}";
  }

  static String dateNow() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour, now.minute)
        .toString()
        .substring(0, 16);
  }

  static String substringText(String text, int len) {
    if (text.length < len) return text;
    return "${text.substring(0, len - 1)}...";
  }

  static String countRating(int? r, int? n) {
    int rating = r ?? 0;
    int num = n ?? 0;
    return (rating / num).toStringAsFixed(2);
  }
}
