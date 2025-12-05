import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/hive/index.dart';
import '../../../../core/utils/fake_network_delay.dart';
import '../../../../core/utils/password_hasher.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../dtos/auth_record_dto.dart';
import '../dtos/user_dto.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final HiveService _hiveService;
  AuthRepositoryImpl(this._hiveService);

  static const String _authRecordKey = 'auth_record';
  static const String _userRecordKey = 'user_record';
  static const String _currentUserKey = 'current_user';

  @override
  Future<Result<User>> login({
    required String email,
    required String password,
  }) async {
    try {
      final authRecords = _hiveService.readListMap<AuthRecordDto>(
        _authRecordKey,
        fromJson: AuthRecordDto.fromJson,
      );

      if (authRecords == null || authRecords.isEmpty) {
        return Result.failure(const UserNotFoundFailure());
      }

      final authRecord = authRecords.firstWhere(
        (record) => record.email == email,
        orElse: () => const AuthRecordDto(),
      );

      if (authRecord.email == null || authRecord.hashedPassword == null) {
        return Result.failure(const UserNotFoundFailure());
      }

      if (!PasswordHasher.verify(password, authRecord.hashedPassword!)) {
        return Result.failure(const InvalidCredentialsFailure());
      }

      final userRecords = _hiveService.readListMap<UserDto>(
        _userRecordKey,
        fromJson: UserDto.fromJson,
      );

      if (userRecords == null || userRecords.isEmpty) {
        return Result.failure(const UserDataNotFoundFailure());
      }

      final userDto = userRecords.firstWhere(
        (user) => user.email == email,
        orElse: () => const UserDto(),
      );

      final user = userDto.toDomain();
      if (!user.isValid) {
        return Result.failure(const UserDataNotFoundFailure());
      }

      await _setCurrentUser(userDto);
      await FakeNetworkDelay.delay();
      return Result.success(user);
    } on CacheReadException {
      return Result.failure(CacheReadFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  Future<Result<User>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final existingAuthRecords = _hiveService.readListMap<AuthRecordDto>(
        _authRecordKey,
        fromJson: AuthRecordDto.fromJson,
      );

      if (existingAuthRecords != null) {
        final emailExists = existingAuthRecords.any(
          (record) => record.email == email,
        );
        if (emailExists) {
          return Result.failure(const EmailAlreadyExistsFailure());
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
      await FakeNetworkDelay.delay();

      return Result.success(userDto.toDomain());
    } on CacheWriteException {
      return Result.failure(const FailedToRegisterUserFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  Future<Result<User>> getCurrentUser() async {
    try {
      await FakeNetworkDelay.delay();
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
      return Result.success(null);
    } on CacheWriteException {
      return Result.failure(CacheWriteFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
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
