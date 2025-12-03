import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/value_objects/email.dart';
import '../../domain/value_objects/name.dart';
import '../../domain/value_objects/password.dart';

class RegisterState extends Equatable {
  const RegisterState({
    required this.name,
    required this.email,
    required this.password,
    this.isLoading = false,
    this.failure,
  });

  final Name name;
  final Email email;
  final Password password;
  final bool isLoading;
  final Failure? failure;

  factory RegisterState.initial() {
    return RegisterState(
      name: Name(null),
      email: Email(null),
      password: Password(null),
    );
  }

  bool get isFormValid => name.isValid && email.isValid && password.isValid;

  RegisterState copyWith({
    Name? name,
    Email? email,
    Password? password,
    bool? isLoading,
    Failure? failure,
  }) {
    return RegisterState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [name, email, password, isLoading, failure];
}
