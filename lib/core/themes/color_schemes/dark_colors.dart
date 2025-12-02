import 'package:flutter/material.dart';
import 'app_colors.dart';

final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // Primary colors
  primary: AppColors.darkAccentBlue,
  onPrimary: AppColors.darkWhite,
  primaryContainer: AppColors.darkBlueAlice,
  onPrimaryContainer: AppColors.darkWhite,

  // Secondary colors
  secondary: AppColors.darkGrey,
  onSecondary: AppColors.darkWhite,
  secondaryContainer: AppColors.darkGreyGainsboro,
  onSecondaryContainer: AppColors.darkWhite,

  // Tertiary colors (for message bubbles)
  tertiary: AppColors.darkAccentBlue,
  onTertiary: AppColors.darkWhite,
  tertiaryContainer: AppColors.darkBlueAlice,
  onTertiaryContainer: AppColors.darkWhite,

  // Error colors
  error: AppColors.darkAccentRed,
  onError: AppColors.darkWhite,
  errorContainer: Color(0xFF5C1414),
  onErrorContainer: Color(0xFFFFCDD2),

  // Surface colors
  surface: AppColors.darkWhiteSnow,
  onSurface: AppColors.darkWhite,
  surfaceContainerHighest: AppColors.darkWhiteSmoke,
  onSurfaceVariant: AppColors.darkGrey,

  // Outline colors
  outline: AppColors.darkGreyWhisper,
  outlineVariant: AppColors.darkGreyGainsboro,

  // Shadow
  shadow: AppColors.shadowColor,
  scrim: Colors.black87,

  // Inverse colors
  inverseSurface: AppColors.darkWhite,
  onInverseSurface: AppColors.darkBlack,
  inversePrimary: AppColors.darkAccentBlue,
);

extension DarkColorScheme on ColorScheme {
  Color get inputFilledColor => AppColors.darkWhiteSmoke;
  Color get appBarTitleColor => AppColors.darkBlack;
}
