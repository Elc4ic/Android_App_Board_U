part of 'values.dart';

class LightColorConst {
  static const Color main = Color(0xff509EEF);
  static const Color background = Color(0xfff5f8fd);
  static const Color text = Color(0xff001021);
  static const Color card = Color(0xffe1f1ff);
}

class DColorConst {
  static const Color main = Color(0xff509EEF);
  static const Color background = Color(0xff012b5b);
  static const Color text = Color(0xfff9fcff);
  static const Color card = Color(0xff00468c);
}

class MyColorConst {
  static const Color main = Color(0xfff3f3f3);
  static const Color background = Color(0xffededed);
  static const Color text = Color(0xff161c20);
  static const Color card = Color(0xff92b0c4);
  static const Color error = Color(0xfff31d59);
}
/*8aa3b3*/
ColorScheme dark = const ColorScheme(
    brightness: Brightness.light,
    primary: MyColorConst.main,
    onPrimary: MyColorConst.text,
    secondary: MyColorConst.card,
    onSecondary: MyColorConst.text,
    error: MyColorConst.error,
    onError: MyColorConst.text,
    surface: MyColorConst.background,
    onSurface: MyColorConst.text);
