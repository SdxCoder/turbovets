import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbovetschat/config/routes/app_router.dart';
import 'package:turbovetschat/core/widgets/base_action_dialog_widget.dart';
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
                Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.link),
                  title: const Text('Server URL'),
                  subtitle: Text(
                    state.dashboardServerUrl.isEmpty
                        ? 'Using platform default'
                        : state.dashboardServerUrl,
                  ),
                  trailing: const Icon(Icons.edit),
                  onTap: () => _handleConfigureServer(context, state),
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

  void _handleConfigureServer(BuildContext context, SettingsState state) {
    final controller = TextEditingController(text: state.dashboardServerUrl);

    context.router.openDialog(
      child: BaseActionDialogWidget(
        actionText: 'Save',
        cancelText: 'Cancel',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Configure Dashboard Server',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Enter the server address for the Internal Tools Dashboard:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Server URL',
                hintText: 'http://192.168.1.100:4200',
                prefixIcon: Icon(Icons.link),
                border: OutlineInputBorder(),
                helperText: 'Leave empty to use platform default',
                helperMaxLines: 2,
              ),
              keyboardType: TextInputType.url,
              autocorrect: false,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Default URLs:',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '• Android Emulator: http://10.0.2.2:4200\n'
                    '• iOS Simulator: http://localhost:4200\n'
                    '• Physical Device: http://YOUR_IP:4200',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'For physical devices:\n'
              '1. Find your PC\'s IP (ipconfig/ifconfig)\n'
              '2. Enter: http://YOUR_IP:4200\n'
              '3. Ensure PC and phone are on same WiFi',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () {
                  controller.clear();
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Use Default'),
              ),
            ),
          ],
        ),
        onCancel: () => context.router.pop(),
        onAction: () {
          final url = controller.text.trim();
          context.read<SettingsCubit>().setDashboardServerUrl(url).then((_) {
            if (context.mounted) {
              context.router.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    url.isEmpty
                        ? 'Server URL set to platform default'
                        : 'Server URL updated: $url',
                  ),
                ),
              );
            }
          });
        },
      ),
    );
  }
}
