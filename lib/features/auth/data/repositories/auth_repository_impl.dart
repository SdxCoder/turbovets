import 'package:uuid/uuid.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/hive/index.dart';
import '../../../../core/utils/password_hasher.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../dtos/auth_record_dto.dart';
import '../dtos/user_dto.dart';
import '../dtos/user_dto_extension.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._hiveService);

  final HiveService _hiveService;
  static const String _authRecordKey = 'auth_record';
  static const String _userRecordKey = 'user_record';
  static const String _currentUserKey = 'current_user';

  @override
  Future<Result<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        return Result.failure(
          const CacheFailure(code: 'EMAIL_OR_PASSWORD_EMPTY'),
        );
      }

      final authRecords = _hiveService.readListMap<AuthRecordDto>(
        _authRecordKey,
        fromJson: AuthRecordDto.fromJson,
      );

      if (authRecords == null || authRecords.isEmpty) {
        return Result.failure(const CacheFailure(code: 'USER_NOT_FOUND'));
      }

      final authRecord = authRecords.firstWhere(
        (record) => record.email == email,
        orElse: () => const AuthRecordDto(),
      );

      if (authRecord.email == null || authRecord.hashedPassword == null) {
        return Result.failure(const CacheFailure(code: 'USER_NOT_FOUND'));
      }

      if (!PasswordHasher.verify(password, authRecord.hashedPassword!)) {
        return Result.failure(const CacheFailure(code: 'INVALID_CREDENTIALS'));
      }

      final userRecords = _hiveService.readListMap<UserDto>(
        _userRecordKey,
        fromJson: UserDto.fromJson,
      );

      if (userRecords == null || userRecords.isEmpty) {
        return Result.failure(const CacheFailure(code: 'USER_DATA_NOT_FOUND'));
      }

      final userDto = userRecords.firstWhere(
        (user) => user.email == email,
        orElse: () => const UserDto(),
      );

      final user = userDto.toDomain();
      if (!user.isValid) {
        return Result.failure(const CacheFailure(code: 'USER_DATA_NOT_FOUND'));
      }

      await _setCurrentUser(userDto);
      return Result.success(user);
    } on CacheReadException catch (e) {
      return Result.failure(CacheFailure(code: e.message));
    } catch (e) {
      return Result.failure(UnknownFailure(code: e.toString()));
    }
  }

  @override
  Future<Result<User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (name.isEmpty || email.isEmpty || password.isEmpty) {
        return Result.failure(
          const CacheFailure(code: 'REQUIRED_FIELDS_EMPTY'),
        );
      }

      final existingAuthRecords = _hiveService.readListMap<AuthRecordDto>(
        _authRecordKey,
        fromJson: AuthRecordDto.fromJson,
      );

      if (existingAuthRecords != null) {
        final emailExists = existingAuthRecords.any(
          (record) => record.email == email,
        );
        if (emailExists) {
          return Result.failure(
            const CacheFailure(code: 'EMAIL_ALREADY_EXISTS'),
          );
        }
      }

      final hashedPassword = PasswordHasher.hash(password);
      final userId = const Uuid().v4();

      final authRecord = AuthRecordDto(
        email: email,
        hashedPassword: hashedPassword,
      );

      final userDto = UserDto(id: userId, name: name, email: email);

      await _addAuthRecord(authRecord);
      await _addUserRecord(userDto);
      await _setCurrentUser(userDto);

      return Result.success(userDto.toDomain());
    } on CacheWriteException {
      return Result.failure(CacheFailure(code: 'FAILED_TO_REGISTER_USER'));
    } catch (e) {
      return Result.failure(UnknownFailure(code: e.toString()));
    }
  }

  @override
  Future<Result<User?>> getCurrentUser() async {
    try {
      final currentUser = _hiveService.read<UserDto>(_currentUserKey);
      if (currentUser == null) {
        return Result.success(null);
      }

      return Result.success(currentUser.toDomain());
    } on CacheReadException catch (e) {
      return Result.failure(CacheFailure(code: e.message));
    } catch (e) {
      return Result.failure(UnknownFailure(code: e.toString()));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _hiveService.remove(_currentUserKey);
      return Result.success(null);
    } on CacheWriteException catch (e) {
      return Result.failure(CacheFailure(code: e.message));
    } catch (e) {
      return Result.failure(UnknownFailure(code: e.toString()));
    }
  }

  Future<void> _setCurrentUser(UserDto userDto) async {
    await _hiveService.save(
      HiveContent.map(key: _currentUserKey, value: userDto.toJson()),
    );
  }

  Future<void> _addAuthRecord(AuthRecordDto authRecord) async {
    final existingRecords =
        _hiveService.readListMap<AuthRecordDto>(
          _authRecordKey,
          fromJson: AuthRecordDto.fromJson,
        ) ??
        [];

    final updatedRecords = [...existingRecords, authRecord];
    final recordsJson = updatedRecords
        .map((record) => record.toJson())
        .toList();

    await _hiveService.save(
      HiveContent.listMap(key: _authRecordKey, value: recordsJson),
    );
  }

  Future<void> _addUserRecord(UserDto userDto) async {
    final existingRecords =
        _hiveService.readListMap<UserDto>(
          _userRecordKey,
          fromJson: UserDto.fromJson,
        ) ??
        [];

    final updatedRecords = [...existingRecords, userDto];
    final recordsJson = updatedRecords
        .map((record) => record.toJson())
        .toList();

    await _hiveService.save(
      HiveContent.listMap(key: _userRecordKey, value: recordsJson),
    );
  }
}
