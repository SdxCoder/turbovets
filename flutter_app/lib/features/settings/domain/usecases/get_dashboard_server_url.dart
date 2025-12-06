import 'package:injectable/injectable.dart';

import '../../../../core/errors/result.dart';
import '../repositories/settings_repository.dart';

@injectable
class GetDashboardServerUrl {
  const GetDashboardServerUrl(this._repository);

  final SettingsRepository _repository;

  Future<Result<String>> call() async {
    return _repository.getDashboardServerUrl();
  }
}
