import 'package:flutter/material.dart';
import 'package:turbovetschat/core/themes/color_schemes/dark_colors.dart';
import 'package:turbovetschat/core/themes/color_schemes/light_colors.dart';
import 'package:turbovetschat/core/themes/text/text_theme.dart';

import '../radiuses.dart';
import '../spacings.dart';

final InputDecorationTheme appInputTheme = InputDecorationTheme(
  filled: true,
  fillColor: LightColorScheme(lightColorScheme).inputFilledColor,
  labelStyle: appTextTheme.bodyMedium?.copyWith(
    color: lightColorScheme.secondary,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Radii.md),
    borderSide: BorderSide.none,
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Radii.md),
    borderSide: BorderSide.none,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Radii.md),
    borderSide: BorderSide(width: 2, color: lightColorScheme.secondary),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Radii.md),
    borderSide: BorderSide(width: 1, color: lightColorScheme.error),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Radii.md),
    borderSide: BorderSide(width: 2, color: lightColorScheme.error),
  ),
  contentPadding: const EdgeInsets.symmetric(
    horizontal: Spacing.md,
    vertical: Spacing.md,
  ),
  isDense: true,
);

final InputDecorationTheme appInputThemeDark = appInputTheme.copyWith(
  fillColor: DarkColorScheme(darkColorScheme).inputFilledColor,
  labelStyle: appTextTheme.bodyMedium?.copyWith(
    color: darkColorScheme.secondary,
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Radii.md),
    borderSide: BorderSide(width: 2, color: darkColorScheme.secondary),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Radii.md),
    borderSide: BorderSide(width: 1, color: darkColorScheme.error),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(Radii.md),
    borderSide: BorderSide(width: 2, color: darkColorScheme.error),
  ),
);
