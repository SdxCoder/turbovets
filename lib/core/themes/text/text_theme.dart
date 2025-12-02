import 'package:flutter/material.dart';
import '../typography.dart';

const TextTheme appTextTheme = TextTheme(
  // Title: Bold 22 (Title in design system)
  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeights.bold,
    height: 1.27,
    fontFamily: Fonts.primary,
  ),

  // Headline-Bold: Bold 16
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeights.bold,
    fontFamily: Fonts.primary,
  ),

  // Headline: Medium 16
  titleSmall: TextStyle(
    fontSize: 16,
    fontWeight: FontWeights.medium,
    fontFamily: Fonts.primary,
  ),

  // Body-Bold: Bold 14
  bodyLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeights.bold,
    fontFamily: Fonts.primary,
  ),

  // Body: Medium 14
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeights.medium,
    fontFamily: Fonts.primary,
  ),

  // Footnote-Bold
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeights.semiBold,
    fontFamily: Fonts.primary,
  ),

  // Footnote: Regular 12
  labelLarge: TextStyle(
    fontSize: 12,
    fontWeight: FontWeights.regular,
    fontFamily: Fonts.primary,
  ),

  // Caption-Bold: Bold 10
  labelMedium: TextStyle(
    fontSize: 10,
    fontWeight: FontWeights.bold,
    fontFamily: Fonts.primary,
  ),

  // Caption: Regular 10
  labelSmall: TextStyle(
    fontSize: 10,
    fontWeight: FontWeights.regular,
    fontFamily: Fonts.primary,
  ),
);

/// Text theme for dark mode (same as light)
const TextTheme appTextThemeDark = appTextTheme;
