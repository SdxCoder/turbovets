import 'package:flutter/material.dart';

import '../color_schemes/dark_colors.dart';
import '../color_schemes/light_colors.dart';
import '../radiuses.dart';
import '../text/text_theme.dart';

final DialogThemeData appDialogTheme = DialogThemeData(
  backgroundColor: LightColorScheme(lightColorScheme).dialogBackgroundColor,
  titleTextStyle: appTextTheme.titleMedium,
  contentTextStyle: appTextTheme.bodyLarge,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.lg)),
);

final DialogThemeData appDialogThemeDark = DialogThemeData(
  backgroundColor: DarkColorScheme(darkColorScheme).dialogBackgroundColor,
  titleTextStyle: appTextTheme.titleMedium,
  contentTextStyle: appTextTheme.bodyLarge,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Radii.lg)),
);
