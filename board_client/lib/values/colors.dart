part of 'values.dart';

class themeColors {
  Brightness brightness = Brightness.light;
  Color main = const Color(0xfff2f2f2);
  Color card = const Color(0xffd3d9e1);
  Color primary = const Color(0xff0d4b75);
  Color text = const Color(0xff211f20);
  Color error = const Color(0xfff31d59);
}

class darkColors implements themeColors {
  @override
  Brightness brightness = Brightness.dark;
  @override
  Color main = const Color(0xff1F1F1F);
  @override
  Color card = const Color(0xff424040);
  @override
  Color primary = const Color(0xffD5FF5F);
  @override
  Color text = const Color(0xffF5E9DD);
  @override
  Color error = const Color(0xfff31d59);
}

class beigeColors implements themeColors {
  @override
  Brightness brightness = Brightness.light;
  @override
  Color main = const Color(0xffF5E9DD);
  @override
  Color card = const Color(0xff827777);
  @override
  Color primary = const Color(0xffE75E54);
  @override
  Color text = const Color(0xff3B2929);
  @override
  Color error = const Color(0xff880015);
}

ColorScheme scheme(themeColors colors) {
  return ColorScheme(
    brightness: colors.brightness,
    primary: colors.primary,
    onPrimary: colors.text,
    secondary: colors.card,
    onSecondary: colors.text,
    tertiary: colors.primary,
    onTertiary: colors.text,
    error: colors.error,
    onError: colors.text,
    surface: colors.main,
    onSurface: colors.text,
  );
}
