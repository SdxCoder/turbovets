import '../../../../core/errors/result.dart';
import '../../../auth/domain/entities/user.dart';

abstract class SettingsRepository {
  Future<Result<User>> getCurrentUser();
  Future<Result<void>> logout();
  Future<Result<String>> getThemeMode();
  Future<Result<void>> setThemeMode(String themeMode);
  Future<Result<String>> getDashboardServerUrl();
  Future<Result<void>> setDashboardServerUrl(String url);
}
