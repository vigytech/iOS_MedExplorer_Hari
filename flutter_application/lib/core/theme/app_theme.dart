import 'package:flutter/material.dart';

/// Clinical light theme designed for maximum legibility in medical environments.
/// Color choices per SITE.md: "Clinical, high-contrast, professional, precision-focused."
/// Canvas BG: White. Sidebar: Light Slate. Text: Charcoal. Accent: Medical Teal.
abstract final class AppTheme {
  // ─── Color Palette (Light Clinical) ───────────────────
  static const Color canvasBackground = Color(0xFFFFFFFF); // Pure White
  static const Color sidebarBackground = Color(0xFFF8FAFC); // Slate 50
  static const Color surface = Color(0xFFFFFFFF); // White
  static const Color surfaceVariant = Color(0xFFF1F5F9); // Slate 100
  static const Color surfaceElevated = Color(0xFFE2E8F0); // Slate 200
  static const Color textPrimary = Color(0xFF0F172A); // Slate 900 (Charcoal)
  static const Color textSecondary = Color(0xFF64748B); // Slate 500
  static const Color textTertiary = Color(0xFF94A3B8); // Slate 400
  static const Color accent = Color(0xFF0D9488); // Teal 600 (Medical Teal)
  static const Color accentLight = Color(0xFF14B8A6); // Teal 500
  static const Color danger = Color(0xFFF43F5E); // Rose 500
  static const Color warning = Color(0xFFFBBF24); // Amber 400
  static const Color divider = Color(0xFFE2E8F0); // Slate 200
  static const Color canvasGrid = Color(0xFFE2E8F0); // Subtle grid lines

  // ─── Annotation Brush Preset Colors ───────────────────
  static const Color brushRed = Color(0xFFEF4444);
  static const Color brushBlue = Color(0xFF3B82F6);
  static const Color brushGreen = Color(0xFF22C55E);
  static const Color brushOrange = Color(0xFFF97316);
  static const Color brushBlack = Color(0xFF0F172A);

  // ─── Spacing Scale ────────────────────────────────────
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacingXxl = 48.0;

  // ─── Border Radii ─────────────────────────────────────
  static const double radiusSm = 6.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;

  // ─── Canvas Tokens ────────────────────────────────────
  static const double canvasMinScale = 0.5;
  static const double canvasMaxScale = 4.0;
  static const double gridSnapIncrement = 0.1; // Per ARCHITECTURE_SPEC: "snaps to nearest 0.1 grid vector"
  static const int pathFlattenThreshold = 100;

  // ─── Sidebar Tokens ───────────────────────────────────
  static const double sidebarExpandedWidth = 320.0;
  static const double sidebarCollapsedWidth = 72.0;

  // ─── ThemeData Builder ────────────────────────────────
  static ThemeData buildClinicalTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: surface,
      colorScheme: const ColorScheme.light(
        primary: accent,
        secondary: accentLight,
        surface: surface,
        error: danger,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: textPrimary,
        onError: Colors.white,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: sidebarBackground,
        foregroundColor: textPrimary,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 1,
        shadowColor: const Color(0x1A000000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMd),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: divider,
        thickness: 1,
        space: 0,
      ),
      iconTheme: const IconThemeData(
        color: textSecondary,
        size: 24.0,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: accent,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
