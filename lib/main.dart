import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'config/injection/injection.dart';
import 'config/routes/app_router.dart';
import 'core/services/hive/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveService.instance.init();

  configureDependencies();

  final appRouter = AppRouter();
  runApp(MyApp(appRouter: appRouter));
}
