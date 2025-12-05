import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'config/injection/injection.dart';
import 'config/routes/app_router.dart';
import 'core/services/auto_reply_agent/index.dart';
import 'core/services/hive/hive_service.dart';
import 'mock_data/auto_reply_messages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await HiveService.instance.init();

  AutoReplyAgentService.instance.initialize(
    replyMessages: AutoReplyMessages.messages,
    replyDelay: const Duration(seconds: 5),
  );

  configureDependencies();

  final appRouter = AppRouter();
  runApp(MyApp(appRouter: appRouter));
}
