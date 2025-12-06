import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/result.dart';
import '../repositories/settings_repository.dart';

@injectable
class GetThemeMode {
  const GetThemeMode(this._repository);

  final SettingsRepository _repository;

  Future<Result<ThemeMode>> call() async {
    final result = await _repository.getThemeMode();
    final themeModeString = result.when(success: (t) => t, error: (_) => null);
    final themeMode = _parseThemeMode(themeModeString);

    return result.when(
      success: (_) => Result.success(themeMode),
      error: (failure) => Result.failure(failure),
    );
  }

  ThemeMode _parseThemeMode(String? themeModeString) {
    return ThemeMode.values.firstWhere(
      (mode) => mode.toString() == themeModeString,
      orElse: () => ThemeMode.system,
    );
  }
}
