import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData mainTheme(BuildContext context) => ThemeData(
      colorScheme: dark,
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.montserrat(fontSize: Markup.size_20),
        bodyMedium: GoogleFonts.montserrat(fontSize: Markup.size_14),
        bodySmall: GoogleFonts.montserrat(fontSize: Markup.size_12),

        titleLarge: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: Markup.size_24),
        titleMedium: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: Markup.size_14),
        titleSmall: GoogleFonts.montserrat(fontWeight: FontWeight.w700,fontSize: Markup.size_12),

        labelLarge: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: Markup.size_24,
        ),
        labelMedium: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: Markup.size_16,
        ),
        labelSmall: GoogleFonts.montserrat(
          fontWeight: FontWeight.bold,
          fontSize: Markup.size_12,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: GoogleFonts.montserrat(
          fontSize: Markup.size_14,
        ),
        unselectedItemColor: LightColorConst.text,
        selectedItemColor: LightColorConst.text,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColorConst.card,
          foregroundColor: MyColorConst.text,
        ),
      ),
      cardTheme: const CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          side: BorderSide(
            color: MyColorConst.text,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: GoogleFonts.montserrat(
          fontSize: Markup.size_16,
        ),
        floatingLabelStyle: GoogleFonts.montserrat(
          fontSize: Markup.size_12,
          color: MyColorConst.text,
        ),
        helperStyle: GoogleFonts.montserrat(
          fontSize: Markup.size_16,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        )
      ),
      searchBarTheme: SearchBarThemeData(
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          Theme.of(context).platform: NoAnimationPageTransitionsBuilder(),
        },
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
