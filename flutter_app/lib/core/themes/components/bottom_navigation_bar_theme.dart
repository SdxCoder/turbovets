import 'package:flutter/material.dart';

import '../color_schemes/dark_colors.dart';
import '../color_schemes/light_colors.dart';

final BottomNavigationBarThemeData appBottomNavigationBarTheme =
    BottomNavigationBarThemeData(
      selectedItemColor: lightColorScheme.onSurface,
      unselectedItemColor: lightColorScheme.secondary,
    );

final BottomNavigationBarThemeData appBottomNavigationBarThemeDark =
    BottomNavigationBarThemeData(
      selectedItemColor: darkColorScheme.onSurface,
      unselectedItemColor: darkColorScheme.secondary,
    );
