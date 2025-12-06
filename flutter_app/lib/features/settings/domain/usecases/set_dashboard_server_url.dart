import 'package:injectable/injectable.dart';

import '../../../../core/errors/result.dart';
import '../repositories/settings_repository.dart';

@injectable
class SetDashboardServerUrl {
  const SetDashboardServerUrl(this._repository);

  final SettingsRepository _repository;

  Future<Result<void>> call(String url) async {
    return _repository.setDashboardServerUrl(url);
  }
}
