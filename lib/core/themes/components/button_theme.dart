import 'package:flutter/material.dart';

import '../color_schemes/dark_colors.dart';
import '../color_schemes/light_colors.dart';
import '../radiuses.dart';
import '../text/text_theme.dart';

final ElevatedButtonThemeData appButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Radii.full),
    ),
    padding: EdgeInsets.zero,
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
    elevation: 0,
    textStyle: appTextTheme.titleMedium,
    minimumSize: const Size(double.infinity, 48),
  ),
);

final ElevatedButtonThemeData appButtonThemeDark = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Radii.full),
    ),
    padding: EdgeInsets.zero,
    backgroundColor: darkColorScheme.primary,
    foregroundColor: darkColorScheme.onPrimary,
    elevation: 0,
    textStyle: appTextTheme.titleMedium,
    minimumSize: const Size(double.infinity, 48),
  ),
);

final OutlinedButtonThemeData appOutlinedButtonTheme = OutlinedButtonThemeData(
  style: OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(Radii.full),
    ),
    side: BorderSide(color: lightColorScheme.primary, width: 1),
    minimumSize: const Size(double.infinity, 48),
    textStyle: appTextTheme.titleMedium,
  ),
);

final OutlinedButtonThemeData appOutlinedButtonThemeDark =
    OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Radii.full),
        ),
        side: BorderSide(color: darkColorScheme.primary, width: 1),
        minimumSize: const Size(double.infinity, 48),
        textStyle: appTextTheme.titleMedium,
      ),
    );
