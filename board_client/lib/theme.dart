import 'package:board_client/cubit/app_cubit/app_cubit.dart';
import 'package:board_client/values/values.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData mainTheme(BuildContext context) {
  final appBloc = AppCubit.get(context);
  final scheme = appBloc.scheme;
  return ThemeData(
      colorScheme: scheme,
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
          fontSize: Markup.size_14,
        ),
        labelSmall: GoogleFonts.exo2(
          fontWeight: FontWeight.w700,
          fontSize: Markup.size_12,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedLabelStyle: GoogleFonts.jost(
          fontWeight: FontWeight.w600,
          fontSize: Markup.size_14,
        ),
        backgroundColor: scheme.secondary,
        unselectedItemColor: scheme.onSurface,
        selectedItemColor: scheme.primary,
        type: BottomNavigationBarType.shifting,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.surface,
          textStyle: GoogleFonts.jost(
              color: scheme.surface,
              fontWeight: FontWeight.w700,
              fontSize: Markup.size_16),
        ),
      ),
      cardTheme: CardTheme(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        margin: Markup.padding_h_4_v_4,
        color: scheme.secondary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: GoogleFonts.exo2(
          fontWeight: FontWeight.w400,
          fontSize: Markup.size_16,
        ),
        floatingLabelStyle: GoogleFonts.exo2(
          fontWeight: FontWeight.w400,
          fontSize: Markup.size_12,
          color: scheme.onSurface,
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
        fillColor: scheme.onSurface.withAlpha(25),
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
            scheme.onSurface.withAlpha(25),
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          elevation: WidgetStateProperty.all(8),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 20,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: scheme.surface,
      ),
      searchBarTheme: SearchBarThemeData(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide(color: scheme.onSurface, width: 1),
          ),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(
          scheme.onSurface.withAlpha(25),
        ),
        shadowColor: WidgetStateProperty.all<Color>(
          scheme.onSurface.withAlpha(25),
        ),
        elevation: WidgetStateProperty.all<double>(
          0,
        ),

      ),
      snackBarTheme: SnackBarThemeData(backgroundColor: scheme.error),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: scheme.surface,
      ));
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
