import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primary = Color(0xFFF47051);
  static const Color background = Color(0xFF070707);
  static const Color surface = Color(0xFF1B1B1B);
  static const Color secondaryText = Color(0xFFC6C6C6);
  static const Color white = Colors.white;

  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: background,
    colorScheme: const ColorScheme.dark(
      primary: primary,
      secondary: primary,
      background: background,
      surface: surface,
      onPrimary: white,
      onSecondary: white,
      onBackground: white,
      onSurface: white,
    ),
    useMaterial3: true,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.fredoka(fontSize: 36, fontWeight: FontWeight.w700, color: white),
      displayMedium: GoogleFonts.fredoka(fontSize: 28, fontWeight: FontWeight.w700, color: white),
      headlineSmall: GoogleFonts.fredoka(fontSize: 22, fontWeight: FontWeight.w700, color: white),
      titleLarge: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w600, color: white),
      bodyLarge: GoogleFonts.inter(fontSize: 16, color: secondaryText),
      bodyMedium: GoogleFonts.inter(fontSize: 14, color: secondaryText),
      labelLarge: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: white),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF090909),
      elevation: 0,
      iconTheme: IconThemeData(color: white),
      centerTitle: false,
    ),
    cardTheme: const CardThemeData(
      color: surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      elevation: 4,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF101010),
      selectedItemColor: primary,
      unselectedItemColor: secondaryText,
      showUnselectedLabels: true,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primary,
    ),
  );
}
