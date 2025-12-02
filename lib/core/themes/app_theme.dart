import 'package:flutter/material.dart';
import 'color_schemes/dark_colors.dart';
import 'color_schemes/light_colors.dart';
import 'components/app_bar_theme.dart';
import 'components/button_theme.dart';
import 'components/input_theme.dart';
import 'text/text_theme.dart';

/// Main theme configuration for TurboVets Chat
class AppTheme {
  AppTheme._();

  /// Light theme
  static ThemeData light = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: lightColorScheme,
    textTheme: appTextTheme,
    // Component themes
    appBarTheme: appBarTheme,
    elevatedButtonTheme: appButtonTheme,

    outlinedButtonTheme: appOutlinedButtonTheme,
    inputDecorationTheme: appInputTheme,

    // Additional configurations
    scaffoldBackgroundColor: lightColorScheme.surface,
    dividerColor: lightColorScheme.outline,
    splashFactory: InkRipple.splashFactory,
  );

  /// Dark theme
  static ThemeData dark = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: darkColorScheme,
    textTheme: appTextThemeDark,

    // Component themes
    appBarTheme: appBarThemeDark,
    elevatedButtonTheme: appButtonThemeDark,
    outlinedButtonTheme: appOutlinedButtonThemeDark,
    inputDecorationTheme: appInputThemeDark,

    // Additional configurations
    scaffoldBackgroundColor: darkColorScheme.surface,
    dividerColor: darkColorScheme.outline,
    splashFactory: InkRipple.splashFactory,
  );
}
