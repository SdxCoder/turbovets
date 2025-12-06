part of 'package:turbovetschat/core/errors/failures.dart';

sealed class AuthFailure extends Failure {
  const AuthFailure({super.code});
}

final class InvalidEmailFailure extends AuthFailure {
  const InvalidEmailFailure() : super(code: 'INVALID_EMAIL');
}

final class InvalidPasswordFailure extends AuthFailure {
  const InvalidPasswordFailure() : super(code: 'INVALID_PASSWORD');
}

final class InvalidNameFailure extends AuthFailure {
  const InvalidNameFailure() : super(code: 'INVALID_NAME');
}

final class UserNotFoundFailure extends AuthFailure {
  const UserNotFoundFailure() : super(code: 'USER_NOT_FOUND');
}

final class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure() : super(code: 'INVALID_CREDENTIALS');
}

final class UserDataNotFoundFailure extends AuthFailure {
  const UserDataNotFoundFailure() : super(code: 'USER_DATA_NOT_FOUND');
}

final class EmailAlreadyExistsFailure extends AuthFailure {
  const EmailAlreadyExistsFailure() : super(code: 'EMAIL_ALREADY_EXISTS');
}

final class FailedToRegisterUserFailure extends AuthFailure {
  const FailedToRegisterUserFailure() : super(code: 'FAILED_TO_REGISTER_USER');
}
