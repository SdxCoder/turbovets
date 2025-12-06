import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:turbovetschat/core/services/hive/hive_service.dart';
import 'package:turbovetschat/features/settings/presentation/bloc/settings_cubit.dart';

import 'app.dart';
import 'config/injection/injection.dart';
import 'config/routes/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  configureDependencies();
  await HiveService.instance.init();

  final appRouter = AppRouter();
  runApp(
    BlocProvider(
      create: (_) => getIt<SettingsCubit>(),
      child: MyApp(appRouter: appRouter),
    ),
  );
}
