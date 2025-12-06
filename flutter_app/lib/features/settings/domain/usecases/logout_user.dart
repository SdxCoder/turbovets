import 'package:injectable/injectable.dart';

import '../../../../core/errors/result.dart';
import '../repositories/settings_repository.dart';

@injectable
class LogoutUser {
  const LogoutUser(this._repository);

  final SettingsRepository _repository;

  Future<Result<void>> call() async {
    return _repository.logout();
  }
}
