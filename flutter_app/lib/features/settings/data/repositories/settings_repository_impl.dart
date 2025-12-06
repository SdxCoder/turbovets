import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/hive/index.dart';
import '../../../auth/data/dtos/user_dto.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/repositories/settings_repository.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  SettingsRepositoryImpl(this._hiveService);

  final HiveService _hiveService;

  static const String _currentUserKey = 'current_user';
  static const String _themeModeKey = 'theme_mode';

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      final currentUser = _hiveService.readMap<UserDto>(
        _currentUserKey,
        fromJson: UserDto.fromJson,
      );

      if (currentUser == null) {
        return Result.success(User.empty());
      }

      final user = currentUser.toDomain();
      if (!user.isValid) {
        return Result.failure(const UserDataNotFoundFailure());
      }

      return Result.success(user);
    } on CacheReadException {
      return Result.failure(CacheReadFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _hiveService.remove(_currentUserKey);
      await _hiveService.remove(_themeModeKey);
      return Result.success(null);
    } on CacheWriteException {
      return Result.failure(CacheWriteFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  Future<Result<String>> getThemeMode() async {
    try {
      final themeModeString = _hiveService.read<String>(_themeModeKey);

      if (themeModeString == null) {
        return Result.success('ThemeMode.system');
      }

      return Result.success(themeModeString);
    } on CacheReadException {
      return Result.failure(CacheReadFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  Future<Result<void>> setThemeMode(String themeMode) async {
    try {
      await _hiveService.save(
        HiveContent.string(key: _themeModeKey, value: themeMode),
      );
      return Result.success(null);
    } on CacheWriteException {
      return Result.failure(CacheWriteFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }
}
