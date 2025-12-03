import 'package:equatable/equatable.dart';

part 'auth_failures.dart';

/// Base class for all failures in the app
/// Uses sealed classes for exhaustive pattern matching
sealed class Failure extends Equatable {
  const Failure({this.code});

  final String? code;

  @override
  List<Object?> get props => [code];
}

/// Cache/local storage failures
class CacheFailure extends Failure {
  const CacheFailure({super.code});
}

/// Unknown/unexpected failures
class UnknownFailure extends Failure {
  const UnknownFailure({super.code});
}
