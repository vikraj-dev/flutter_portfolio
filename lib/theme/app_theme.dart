import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// ---------------------------------------------------------------------------
/// COLORS
/// Change these to re-skin the whole portfolio with your own brand colors.
/// ---------------------------------------------------------------------------
class AppColors {
  AppColors._();

  static const Color background = Color(0xFF070B14);
  static const Color surface = Color(0xFF0E1422);
  static const Color surfaceLight = Color(0xFF161E30);
  static const Color border = Color(0xFF232C42);

  static const Color primary = Color(0xFF4F8CFF);
  static const Color secondary = Color(0xFF8B5CF6);
  static const Color accentTeal = Color(0xFF13E1C0);
  static const Color accentPink = Color(0xFFFF5C8A);

  static const Color textPrimary = Color(0xFFEAEFF7);
  static const Color textSecondary = Color(0xFF8C97AC);
  static const Color textMuted = Color(0xFF5C6678);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, secondary],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

/// ---------------------------------------------------------------------------
/// TEXT STYLES
/// Headings use Poppins, body text uses Inter — a clean, modern pairing.
/// ---------------------------------------------------------------------------
class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading({
    double size = 32,
    Color? color,
    FontWeight weight = FontWeight.w700,
  }) {
    return GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight,
      color: color ?? AppColors.textPrimary,
      height: 1.25,
    );
  }

  static TextStyle body({
    double size = 16,
    Color? color,
    FontWeight weight = FontWeight.w400,
  }) {
    return GoogleFonts.inter(
      fontSize: size,
      fontWeight: weight,
      color: color ?? AppColors.textSecondary,
      height: 1.6,
    );
  }
}

/// ---------------------------------------------------------------------------
/// THEME DATA
/// ---------------------------------------------------------------------------
class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: GoogleFonts.inter().fontFamily,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
      ),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
