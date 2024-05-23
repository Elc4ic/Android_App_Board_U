part of 'values.dart';

class LightColorConst {
  static const Color main = Color(0xff509EEF);
  static const Color background = Color(0xfff5f8fd);
  static const Color text = Color(0xff001021);
  static const Color card = Color(0xffe1f1ff);
}

class DarkColorConst {
  static const Color main = Color(0xff509EEF);
  static const Color background = Color(0xff012b5b);
  static const Color text = Color(0xfff9fcff);
  static const Color card = Color(0xff00468c);
}

ColorScheme dark = const ColorScheme(
    brightness: Brightness.dark,
    primary: DarkColorConst.main,
    onPrimary: DarkColorConst.main,
    secondary: DarkColorConst.card,
    onSecondary: DarkColorConst.main,
    error: DarkColorConst.main,
    onError: DarkColorConst.main,
    background: DarkColorConst.background,
    onBackground: DarkColorConst.main,
    surface: DarkColorConst.main,
    onSurface: DarkColorConst.text);
