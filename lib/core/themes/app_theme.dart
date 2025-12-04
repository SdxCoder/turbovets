import 'package:flutter/material.dart';

import 'color_schemes/dark_colors.dart';
import 'color_schemes/light_colors.dart';
import 'components/app_bar_theme.dart';
import 'components/bottom_navigation_bar_theme.dart';
import 'components/button_theme.dart';
import 'components/dialog_theme.dart';
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
    textButtonTheme: appTextButtonTheme,
    inputDecorationTheme: appInputTheme,
    bottomNavigationBarTheme: appBottomNavigationBarTheme,
    dialogTheme: appDialogTheme,
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
    textButtonTheme: appTextButtonThemeDark,
    inputDecorationTheme: appInputThemeDark,
    bottomNavigationBarTheme: appBottomNavigationBarThemeDark,
    dialogTheme: appDialogThemeDark,
    // Additional configurations
    scaffoldBackgroundColor: darkColorScheme.surface,
    dividerColor: darkColorScheme.outline,
    splashFactory: InkRipple.splashFactory,
  );
}
