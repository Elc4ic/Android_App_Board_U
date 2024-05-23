import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';

ThemeData mainTheme(BuildContext context) {
  return ThemeData(
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        Theme.of(context).platform: NoAnimationPageTransitionsBuilder(),
      },
    ),
    primarySwatch: Colors.indigo,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedLabelStyle: Styles.navBarText(),
      unselectedItemColor: Colors.black,
      selectedItemColor: Colors.black,
    ),

  );
}

class NoAnimationPageTransitionsBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
