import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ============ LIGHT THEME COLORS ============

  /// Light Theme - Greys
  static const Color lightBlack = Color(0xFF000000);
  static const Color lightGrey = Color(0xFF6B7280);
  static const Color lightGreyGainsboro = Color(0xFFDCDCDC);
  static const Color lightGreyWhisper = Color(0xFFE5E7EB);
  static const Color lightWhiteSmoke = Color(0xFFF5F5F5);
  static const Color lightWhiteSnow = Color(0xFFFAFAFA);
  static const Color lightWhite = Color(0xFFFFFFFF);
  static const Color lightBlueAlice = Color(0xFFF0F9FF);

  /// Light Theme - Accents
  static const Color lightAccentBlue = Color(0xFF3B82F6);
  static const Color lightAccentRed = Color(0xFFEF4444);
  static const Color lightAccentGreen = Color(0xFF10B981);

  // ============ DARK THEME COLORS ============

  /// Dark Theme - Greys
  static const Color darkBlack = Color(0xFF000000);
  static const Color darkGrey = Color(0xFF9CA3AF);
  static const Color darkGreyGainsboro = Color(0xFF374151);
  static const Color darkGreyWhisper = Color(0xFF4B5563);
  static const Color darkWhiteSmoke = Color(0xFF1F2937);
  static const Color darkWhiteSnow = Color(0xFF111827);
  static const Color darkWhite = Color(0xFFFFFFFF);
  static const Color darkBlueAlice = Color(0xFF1E3A5F);

  /// Dark Theme - Accents
  static const Color darkAccentBlue = Color(0xFF60A5FA);
  static const Color darkAccentRed = Color(0xFFF87171);
  static const Color darkAccentGreen = Color(0xFF34D399);

  // ============ SEMANTIC COLORS ============

  /// Shadow Colors
  static const Color shadowColor = Color(0x14000000); // 0.08 opacity
  static const Color shadowIconButton = Color(0x40000000); // 0.25 opacity
  static const Color shadowModal = Color(0x99000000); // 0.60 opacity

  /// Border Colors (Light)
  static const Color lightBorderColor = Color(
    0x14000000,
  ); // grey-whisper with 0.08

  /// Border Colors (Dark)
  static const Color darkBorderColor = Color(
    0x29FFFFFF,
  ); // lighter border for dark
}
