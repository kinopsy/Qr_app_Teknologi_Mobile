import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const Color background = Color(0xFFF6F7FB);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF6C63FF);
  static const Color primarySoft = Color(0xFFEEF0FF);
  static const Color mint = Color(0xFF3DDC97);
  static const Color mintSoft = Color(0xFFE4FBF1);
  static const Color textDark = Color(0xFF2B2E4A);
  static const Color textMuted = Color(0xFF9195B5);
  static const Color shadow = Color(0x1A6C63FF);
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle display = GoogleFonts.poppins(
    fontSize: 30,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    letterSpacing: -0.5,
  );

  static TextStyle title = GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  static TextStyle body = GoogleFonts.inter(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
    height: 1.5,
  );

  static TextStyle button = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static TextStyle caption = GoogleFonts.inter(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
  );
}

class AppTheme {
  AppTheme._();

  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: AppColors.shadow,
      blurRadius: 24,
      offset: const Offset(0, 10),
      spreadRadius: -6,
    ),
  ];

  static ThemeData theme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      background: AppColors.background,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.textDark),
      titleTextStyle: AppTextStyles.title,
    ),
    textTheme: TextTheme(
      bodyMedium: AppTextStyles.body,
      titleLarge: AppTextStyles.title,
    ),
  );
}