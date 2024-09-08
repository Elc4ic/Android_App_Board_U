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
  static const Color main = Color(0xfff1f1f6);
  static const Color blue1 = Color(0xff96BDE4);
  static const Color card = Color(0xff559EC6);
  static const Color blue2 = Color(0xff1572B8);
  static const Color blue3 = Color(0xff0d456b);
  static const Color darkblue = Color(0xff062233);
  static const Color text = Color(0xff161c20);
  static const Color error = Color(0xfff31d59);
}

/*8aa3b3*/
ColorScheme dark = const ColorScheme(
  brightness: Brightness.light,
  primary: MyColorConst.blue2,
  onPrimary: MyColorConst.text,
  secondary: MyColorConst.card,
  onSecondary: MyColorConst.text,
  tertiary: MyColorConst.blue2,
  onTertiary: MyColorConst.main,
  error: MyColorConst.error,
  onError: MyColorConst.text,
  surface: MyColorConst.main,
  onSurface: MyColorConst.text,
);
