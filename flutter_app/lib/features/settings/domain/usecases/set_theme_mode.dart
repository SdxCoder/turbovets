import 'package:injectable/injectable.dart';

import '../../../../core/errors/result.dart';
import '../repositories/settings_repository.dart';

@injectable
class SetThemeMode {
  const SetThemeMode(this._repository);

  final SettingsRepository _repository;

  Future<Result<void>> call(String themeMode) async {
    return _repository.setThemeMode(themeMode);
  }
}

