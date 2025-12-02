import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'config/routes/app_router.dart';
import 'core/services/hive/hive_service.dart';
import 'core/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveService.instance.init();

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
