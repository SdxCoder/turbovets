import 'package:injectable/injectable.dart';
import 'package:turbovetschat/core/errors/failures.dart';

import '../../../../core/errors/result.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../value_objects/email.dart';
import '../value_objects/password.dart';

@injectable
class Login {
  const Login(this._repository);

  final AuthRepository _repository;

  Future<Result<User>> call({
    required String email,
    required String password,
  }) async {
    final emailValueObject = Email(email);
    if (!emailValueObject.isValid) {
      return Result.failure<User>(const InvalidEmailFailure());
    }

    final passwordValueObject = Password(password);
    if (!passwordValueObject.isValid) {
      return Result.failure<User>(const InvalidPasswordFailure());
    }

    return _repository.login(
      email: emailValueObject.value,
      password: passwordValueObject.value,
    );
  }
}
