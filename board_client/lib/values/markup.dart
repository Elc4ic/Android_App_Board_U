part of 'values.dart';

class Markup {
  //sizes
  static const double size_12 = 12.0;
  static const double size_14 = 14.0;
  static const double size_16 = 16.0;
  static const double size_20 = 20.0;
  static const double size_24 = 24.0;
  static const double size_32 = 32.0;
  static const double size_48 = 48.0;
  static const double size_64 = 64.0;

  //padding
  static const EdgeInsets padding_all_8 = EdgeInsets.all(8);
  static const EdgeInsets padding_all_4 = EdgeInsets.all(4);
  static const EdgeInsets padding_all_2 = EdgeInsets.all(2);
  static const EdgeInsets padding_t_l_8 = EdgeInsets.only(left: 8, top: 8);
  static const EdgeInsets padding_h_16_v_4 = EdgeInsets.symmetric(vertical: 4,horizontal: 16);
  static const EdgeInsets padding_h_8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets padding_all_16 = EdgeInsets.all(16);

  //deviders
  static const Widget dividerH5 = SizedBox(height: 5);
  static const Widget dividerH10 = SizedBox(height: 10);
  static const Widget dividerW5 = SizedBox(width: 5);
  static const Widget dividerW10 = SizedBox(width: 10);

  static double widthNow(BuildContext context) {
    return validWidth(MediaQuery.of(context).size.width);
  }

  static double validWidth(double width) {
    return width > 1700 ? 1700 : width;
  }

  static String capitalize(String str) {
    return "${str[0].toUpperCase()}${str.substring(1).toLowerCase()}";
  }

  static String dateNow() {
    DateTime now = DateTime.now();
    return DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute
    ).toString().replaceAll(RegExp(r'\.0+'), '').replaceAll(RegExp(r'\:0+'), '');
  }
}
