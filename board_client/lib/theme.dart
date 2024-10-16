import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData mainTheme(BuildContext context) => ThemeData(
      colorScheme: dark,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.exo2(fontSize: Markup.size_20),
        bodyMedium: GoogleFonts.exo2(fontSize: Markup.size_16),
        bodySmall: GoogleFonts.exo2(fontSize: Markup.size_12),
        titleLarge: GoogleFonts.jost(
            fontWeight: FontWeight.w700, fontSize: Markup.size_20),
        titleMedium: GoogleFonts.jost(
            fontWeight: FontWeight.w700, fontSize: Markup.size_16),
        titleSmall: GoogleFonts.jost(
            fontWeight: FontWeight.w700, fontSize: Markup.size_12),
        labelLarge: GoogleFonts.exo2(
          fontWeight: FontWeight.w700,
          fontSize: Markup.size_24,
        ),
        labelMedium: GoogleFonts.exo2(
          fontWeight: FontWeight.w700,
          fontSize: Markup.size_16,
        ),
        labelSmall: GoogleFonts.exo2(
          fontWeight: FontWeight.w700,
          fontSize: Markup.size_14,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: GoogleFonts.jost(
          fontWeight: FontWeight.w600,
          fontSize: Markup.size_14,
        ),
        unselectedItemColor: LightColorConst.text,
        selectedItemColor: LightColorConst.text,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColorConst.card,
          foregroundColor: MyColorConst.text,
          side: BorderSide(width: 1, color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          minimumSize: const Size(0, 50),
        ),
      ),
      cardTheme: const CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0),
          ),
          /*side: BorderSide(
            color: MyColorConst.text,
          ),*/
        ),
        elevation: 0,
        margin: EdgeInsets.all(0),
      ),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.exo2(
            fontWeight: FontWeight.w400,
            fontSize: Markup.size_16,
          ),
          floatingLabelStyle: GoogleFonts.exo2(
            fontWeight: FontWeight.w400,
            fontSize: Markup.size_12,
            color: MyColorConst.text,
          ),
          helperStyle: GoogleFonts.exo2(
            fontWeight: FontWeight.w400,
            fontSize: Markup.size_16,
          ),
          prefixStyle: GoogleFonts.exo2(
            fontWeight: FontWeight.w400,
            fontSize: Markup.size_16,
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(0)),
          )),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          Theme.of(context).platform: NoAnimationPageTransitionsBuilder(),
        },
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          side: BorderSide(color: Colors.black),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          padding: const EdgeInsets.all(0),
        ),
      ),
      dialogTheme: const DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0)),
          side: BorderSide(color: Colors.black, width: 2),
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
          side: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      searchBarTheme: SearchBarThemeData(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(0),
            ),
          ),
        ),
        side: WidgetStateProperty.all<BorderSide>(
          const BorderSide(
            color: Colors.black,
            width: 1,
          )
        ),
      ),
    );

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
