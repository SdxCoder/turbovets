import 'package:flutter/material.dart';
import 'config/routes/app_router.dart';
import 'core/themes/app_theme.dart';

void main() {
  final appRouter = AppRouter();
  runApp(MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'TurboVets Chat',
      theme: AppTheme.light,
      routerConfig: appRouter.config(),
    );
  }
}
