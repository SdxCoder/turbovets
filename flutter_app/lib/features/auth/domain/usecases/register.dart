import 'package:injectable/injectable.dart';
import 'package:turbovetschat/core/errors/failures.dart';

import '../../../../core/errors/result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../value_objects/email.dart';
import '../value_objects/name.dart';
import '../value_objects/password.dart';

@injectable
class Register {
  const Register(this._repository);

  final AuthRepository _repository;

  Future<Result<User>> call({
    required String name,
    required String email,
    required String password,
  }) async {
    final nameValueObject = Name(name);
    if (!nameValueObject.isValid) {
      return Result.failure<User>(const InvalidNameFailure());
    }

    final emailValueObject = Email(email);
    if (!emailValueObject.isValid) {
      return Result.failure<User>(const InvalidEmailFailure());
    }

    final passwordValueObject = Password(password);
    if (!passwordValueObject.isValid) {
      return Result.failure<User>(const InvalidPasswordFailure());
    }

    return _repository.register(
      name: nameValueObject.value,
      email: emailValueObject.value,
      password: passwordValueObject.value,
    );
  }
}
