import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbovetschat/features/settings/presentation/bloc/settings_cubit.dart';
import 'package:turbovetschat/features/settings/presentation/bloc/settings_state.dart';

import 'config/routes/app_router.dart';
import 'core/themes/app_theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) => previous.themeMode != current.themeMode,
      builder: (context, state) {
        final theme = switch (state.themeMode) {
          ThemeMode.light => AppTheme.light,
          ThemeMode.dark => AppTheme.dark,
          ThemeMode.system => AppTheme.light,
        };
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'TurboVets Chat',
          theme: theme,
          routerConfig: appRouter.config(),
        );
      },
    );
  }
}
