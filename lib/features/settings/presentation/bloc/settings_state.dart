import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../core/errors/failures.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.isLoading = false,
    this.themeMode = ThemeMode.system,
    this.failure,
  });

  final bool isLoading;
  final ThemeMode themeMode;
  final Failure? failure;

  SettingsState copyWith({
    bool? isLoading,
    ThemeMode? themeMode,
    Failure? failure,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      themeMode: themeMode ?? this.themeMode,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [isLoading, themeMode, failure];
}
