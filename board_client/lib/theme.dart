import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        unselectedItemColor: MyColorConst.text,
        selectedItemColor: MyColorConst.text,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColorConst.blue2,
          foregroundColor: MyColorConst.text,
          minimumSize: const Size(0, 50),
        ),
      ),
      cardTheme: const CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        elevation: 0,
        margin: EdgeInsets.all(8),
        color: MyColorConst.card,
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
        filled: true,
        fillColor: Colors.black26,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          Theme.of(context).platform: NoAnimationPageTransitionsBuilder(),
        },
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all<Color>(
            Colors.black26,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          elevation: WidgetStateProperty.all(8),
        ),
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: MyColorConst.main,
        foregroundColor: MyColorConst.main,
      ),
      searchBarTheme: SearchBarThemeData(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: Colors.black, width: 1),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          Colors.black26,
        ),
        shadowColor: WidgetStateProperty.all<Color>(
          Colors.black26,
        ),
        elevation: WidgetStateProperty.all<double>(
          0,
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
