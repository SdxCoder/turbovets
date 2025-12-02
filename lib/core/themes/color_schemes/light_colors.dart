import 'package:flutter/material.dart';
import 'app_colors.dart';

final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // Primary colors
  primary: AppColors.lightAccentBlue,
  onPrimary: AppColors.lightWhite,
  primaryContainer: AppColors.lightBlueAlice,
  onPrimaryContainer: AppColors.lightBlack,

  // Secondary colors
  secondary: AppColors.lightGrey,
  onSecondary: AppColors.lightWhite,
  secondaryContainer: AppColors.lightWhiteSmoke,
  onSecondaryContainer: AppColors.lightBlack,

  // Tertiary colors (for message bubbles)
  tertiary: AppColors.lightAccentBlue,
  onTertiary: AppColors.lightWhite,
  tertiaryContainer: AppColors.lightBlueAlice,
  onTertiaryContainer: AppColors.lightBlack,

  // Error colors
  error: AppColors.lightAccentRed,
  onError: AppColors.lightWhite,
  errorContainer: Color(0xFFFFEBEE),
  onErrorContainer: Color(0xFFB71C1C),

  // Surface colors
  surface: AppColors.lightWhite,
  onSurface: AppColors.lightBlack,
  surfaceContainerHighest: AppColors.lightWhiteSmoke,
  onSurfaceVariant: AppColors.lightGrey,

  // Outline colors
  outline: AppColors.lightGreyWhisper,
  outlineVariant: AppColors.lightGreyGainsboro,

  // Shadow
  shadow: AppColors.shadowColor,
  scrim: Colors.black54,

  // Inverse colors
  inverseSurface: AppColors.lightBlack,
  onInverseSurface: AppColors.lightWhite,
  inversePrimary: AppColors.lightAccentBlue,
);

extension LightColorScheme on ColorScheme {
  Color get inputFilledColor => AppColors.lightWhiteSmoke;
  Color get appBarTitleColor => AppColors.lightBlack;
}
