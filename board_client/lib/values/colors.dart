part of 'values.dart';

/*class LightColorConst {
  static const Color main = Color(0xff509EEF);
  static const Color background = Color(0xfff2f2f2);
  static const Color text = Color(0xff001021);
  static const Color card = Color(0xff82aed3);
}

class DColorConst {
  static const Color main = Color(0xff509EEF);
  static const Color background = Color(0xff012b5b);
  static const Color text = Color(0xfff9fcff);
  static const Color card = Color(0xff00468c);
}*/

class MyColorConst {
  static const Color main = Color(0xfff2f2f2);
  static const Color blue1 = Color(0xff96BDE4);
  static const Color card = Color(0xffe7e7e7);
  static const Color blue2 = Color(0xff1572B8);
  static const Color blue3 = Color(0xff0d456b);
  static const Color darkblue = Color(0xff062233);
  static const Color text = Color(0xff211f20);
  static const Color error = Color(0xfff31d59);
}

/*8aa3b3*/
ColorScheme dark = const ColorScheme(
  brightness: Brightness.light,
  primary: MyColorConst.blue2,
  onPrimary: MyColorConst.text,
  secondary: MyColorConst.blue2,
  onSecondary: MyColorConst.text,
  tertiary: MyColorConst.blue2,
  onTertiary: MyColorConst.blue2,
  error: MyColorConst.error,
  onError: MyColorConst.text,
  surface: MyColorConst.main,
  onSurface: MyColorConst.text,
);
