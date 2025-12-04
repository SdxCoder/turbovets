import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:turbovetschat/core/services/hive/hive_service.dart';

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
}
