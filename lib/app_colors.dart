import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primaryBlue = Color(0xFF0095FF);
  static const Color primaryDark = Color(0xFF3A4A6D);
  
  // Neutral Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF7F7F7);
  static const Color black = Color(0xFF000000);
  static const Color gray = Color(0xFFCFCFCF);
  
  // Accent Colors
  static const Color darkRed = Color(0xFFA80000);
  static const Color red = Color(0xFFD60000);
  static const Color brown = Color(0xFF846700);
  static const Color pink = Color(0xFFE28CAB);
  
  // Light Theme Colors
  static const ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primaryBlue,
    onPrimary: white,
    secondary: primaryDark,
    onSecondary: white,
    tertiary: pink,
    onTertiary: white,
    error: red,
    onError: white,
    background: lightGray,
    onBackground: black,
    surface: white,
    onSurface: black,
    surfaceVariant: gray,
    onSurfaceVariant: black,
    outline: gray,
    outlineVariant: lightGray,
    shadow: black,
    scrim: black,
    inverseSurface: black,
    onInverseSurface: white,
    inversePrimary: white,
    surfaceTint: primaryBlue,
  );
  
  // Dark Theme Colors
  static const ColorScheme darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: primaryBlue,
    onPrimary: white,
    secondary: primaryDark,
    onSecondary: white,
    tertiary: pink,
    onTertiary: white,
    error: red,
    onError: white,
    background: black,
    onBackground: white,
    surface: primaryDark,
    onSurface: white,
    surfaceVariant: Color(0xFF2A2F45),
    onSurfaceVariant: white,
    outline: gray,
    outlineVariant: Color(0xFF1A1F35),
    shadow: black,
    scrim: black,
    inverseSurface: white,
    onInverseSurface: black,
    inversePrimary: primaryDark,
    surfaceTint: primaryBlue,
  );
  
  // Custom Color Extensions
  static Color get primary => primaryBlue;
  static Color get secondary => primaryDark;
  static Color get accent => pink;
  static Color get danger => red;
  static Color get warning => brown;
  static Color get success => primaryBlue;
  static Color get info => primaryDark;
  
  // Background Colors
  static Color get scaffoldBackground => lightGray;
  static Color get cardBackground => white;
  static Color get dialogBackground => white;
  
  // Text Colors
  static Color get textPrimary => black;
  static Color get textSecondary => Color(0xFF666666);
  static Color get textHint => gray;
  static Color get textDisabled => Color(0xFF999999);
  
  // Border Colors
  static Color get borderLight => gray;
  static Color get borderMedium => primaryDark;
  static Color get borderDark => black;
  
  // Status Colors
  static Color get successLight => Color(0xFFE8F5E8);
  static Color get warningLight => Color(0xFFFFF3E0);
  static Color get errorLight => Color(0xFFFFEBEE);
  static Color get infoLight => Color(0xFFE3F2FD);
} 