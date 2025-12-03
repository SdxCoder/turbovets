import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/value_objects/email.dart';
import '../../domain/value_objects/password.dart';

class LoginState extends Equatable {
  const LoginState({
    required this.email,
    required this.password,
    this.isLoading = false,
    this.failure,
  });

  final Email email;
  final Password password;
  final bool isLoading;
  final Failure? failure;

  factory LoginState.initial() {
    return LoginState(email: Email(null), password: Password(null));
  }

  bool get isFormValid => email.isValid && password.isValid;

  LoginState copyWith({
    Email? email,
    Password? password,
    bool? isLoading,
    Failure? failure,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [email, password, isLoading, failure];
}
