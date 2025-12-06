import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbovetschat/config/routes/app_router.dart';
import 'package:turbovetschat/features/auth/presentation/bloc/user_cubit.dart';

import '../../../../core/errors/failure_message_mapper.dart';
import '../../../../core/themes/spacings.dart';
import '../bloc/settings_cubit.dart';
import '../bloc/settings_state.dart';
import '../dialogs/change_theme_dialog.dart';
import '../dialogs/logout_dialog.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsCubit settingsCubit;
  const SettingsScreen({super.key, required this.settingsCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: settingsCubit,
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocConsumer<SettingsCubit, SettingsState>(
        listener: (context, state) {
          if (state.failure != null) {
            final failureMessage = FailureMessageMapper.mapFailureToMessage(
              state.failure!,
            );
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(failureMessage.message)));
          }
        },
        builder: (context, state) {
          final userState = context.watch<UserCubit>().state;

          if (state.isLoading || userState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Padding(
            padding: const EdgeInsets.all(Spacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Information',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.person),
                  title: const Text('Name'),
                  subtitle: Text(userState.user.name),
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(userState.user.email),
                ),
                const SizedBox(height: Spacing.xl),
                Text(
                  'Appearance',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.palette),
                  title: const Text('Change Theme'),
                  subtitle: Text(_getThemeModeLabel(state.themeMode)),
                  onTap: () => _handleChangeTheme(context, state.themeMode),
                ),
                const SizedBox(height: Spacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: state.isLoading
                        ? null
                        : () => _handleLogout(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    child: const Text('Logout'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getThemeModeLabel(ThemeMode mode) {
    return switch (mode) {
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
      _ => '',
    };
  }

  void _handleLogout(BuildContext context) {
    context.router.openDialog(
      child: LogoutDialog(
        onLogout: () {
          context.read<SettingsCubit>().logout(context.router);
        },
      ),
    );
  }

  void _handleChangeTheme(BuildContext context, ThemeMode selectedThemeMode) {
    context.router.openDialog(
      child: ChangeThemeDialog(
        selectedTheme: selectedThemeMode,
        onChange: (value) {
          if (value != null) {
            context.read<SettingsCubit>().changeThemeMode(value).then((_) {
              if (context.mounted) {
                context.router.pop();
              }
            });
          }
        },
      ),
    );
  }
}
