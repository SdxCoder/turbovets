import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failures.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.isLoading = false,
    this.themeMode = ThemeMode.light,
    this.dashboardServerUrl = '',
    this.failure,
  });

  final bool isLoading;
  final ThemeMode themeMode;
  final String dashboardServerUrl;
  final Failure? failure;

  SettingsState copyWith({
    bool? isLoading,
    ThemeMode? themeMode,
    String? dashboardServerUrl,
    Failure? failure,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      themeMode: themeMode ?? this.themeMode,
      dashboardServerUrl: dashboardServerUrl ?? this.dashboardServerUrl,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    themeMode,
    dashboardServerUrl,
    failure,
  ];
}
