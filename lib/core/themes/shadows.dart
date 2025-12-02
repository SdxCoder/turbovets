import 'package:flutter/material.dart';
import 'color_schemes/app_colors.dart';

/// Shadow definitions based on design system
class AppShadows {
  AppShadows._();

  static final List<BoxShadow> soft = [
    BoxShadow(
      color: AppColors.shadowColor,
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static final List<BoxShadow> medium = [
    BoxShadow(
      color: AppColors.shadowIconButton,
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  static final List<BoxShadow> iconButton = [
    BoxShadow(
      color: AppColors.shadowIconButton,
      blurRadius: 4,
      offset: const Offset(0, 1),
    ),
  ];

  static final List<BoxShadow> modal = [
    BoxShadow(
      color: AppColors.shadowModal,
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];
}
