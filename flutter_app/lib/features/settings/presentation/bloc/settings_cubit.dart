import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:turbovetschat/config/routes/app_router.dart';

import '../../../../core/errors/result.dart';
import '../../domain/usecases/get_dashboard_server_url.dart';
import '../../domain/usecases/get_theme_mode.dart';
import '../../domain/usecases/logout_user.dart';
import '../../domain/usecases/set_dashboard_server_url.dart';
import '../../domain/usecases/set_theme_mode.dart';
import 'settings_state.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(
    this._getThemeMode,
    this._setThemeMode,
    this._getDashboardServerUrl,
    this._setDashboardServerUrl,
    this._logoutUser,
  ) : super(const SettingsState()) {
    loadSettings();
  }

  final GetThemeMode _getThemeMode;
  final SetThemeMode _setThemeMode;
  final GetDashboardServerUrl _getDashboardServerUrl;
  final SetDashboardServerUrl _setDashboardServerUrl;
  final LogoutUser _logoutUser;

  Future<void> loadSettings() async {
    emit(state.copyWith(isLoading: true));
    final themeResult = await _getThemeMode();
    final serverUrlResult = await _getDashboardServerUrl();
    emit(state.copyWith(isLoading: false));

    themeResult.when(
      success: (themeMode) {
        emit(state.copyWith(themeMode: themeMode));
      },
      error: (failure) {
        // do nothing
      },
    );

    serverUrlResult.when(
      success: (serverUrl) {
        emit(state.copyWith(dashboardServerUrl: serverUrl));
      },
      error: (failure) {
        emit(state.copyWith(dashboardServerUrl: ''));
      },
    );
  }

  Future<void> changeThemeMode(ThemeMode themeMode) async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _setThemeMode(themeMode.toString());

    switch (result) {
      case Success():
        emit(state.copyWith(isLoading: false, themeMode: themeMode));
      case Error(:final failure):
        emit(state.copyWith(isLoading: false, failure: failure));
    }
  }

  Future<void> setDashboardServerUrl(String url) async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _setDashboardServerUrl(url);

    switch (result) {
      case Success():
        emit(state.copyWith(isLoading: false, dashboardServerUrl: url));
      case Error(:final failure):
        emit(state.copyWith(isLoading: false, failure: failure));
    }
  }

  Future<void> logout(StackRouter router) async {
    emit(state.copyWith(isLoading: true, failure: null));

    final result = await _logoutUser();

    switch (result) {
      case Success():
        emit(state.copyWith(isLoading: false));
        router.replaceAll([const WelcomeRoute()]);
      case Error(:final failure):
        emit(state.copyWith(isLoading: false, failure: failure));
    }
  }
}
