import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:turbovetschat/core/services/auto_reply_agent/auto_reply_agent_service.dart';
import 'package:turbovetschat/core/services/hive/hive_service.dart';
import 'package:turbovetschat/mock_data/auto_reply_images.dart';
import 'package:turbovetschat/mock_data/auto_reply_messages.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @lazySingleton
  HiveService get hiveService => HiveService.instance;

  @lazySingleton
  AutoReplyAgentService get autoReplyAgentService =>
      AutoReplyAgentService.instance..initialize(
        replyMessages: AutoReplyMessages.messages,
        imageUrls: AutoReplyImages.imageUrls,
        replyDelay: const Duration(seconds: 2),
      );

  @lazySingleton
  ImagePicker get imagePicker => ImagePicker();
}
