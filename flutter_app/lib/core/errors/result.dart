import 'package:equatable/equatable.dart';
import 'failures.dart';

/// Result type for handling success and failure cases
/// Uses sealed classes for exhaustive pattern matching (Dart 3)
sealed class Result<T> extends Equatable {
  const Result();

  /// Factory method for success
  static Success<T> success<T>(T data) => Success(data);

  /// Factory method for failure
  static Error<T> failure<T>(Failure failure) => Error(failure);
}

/// Success case containing data
class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  List<Object?> get props => [data];
}

/// Error case containing failure
class Error<T> extends Result<T> {
  const Error(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

/// Extension for convenient pattern matching
extension ResultExtension<T> on Result<T> {
  /// Execute different callbacks based on result type
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) error,
  }) {
    return switch (this) {
      Success(:final data) => success(data),
      Error(:final failure) => error(failure),
    };
  }

  /// Check if result is success
  bool get isSuccess => this is Success<T>;

  /// Check if result is error
  bool get isError => this is Error<T>;

  /// Get data if success, null otherwise
  T? get dataOrNull => switch (this) {
    Success(:final data) => data,
    Error() => null,
  };

  /// Get failure if error, null otherwise
  Failure? get failureOrNull => switch (this) {
    Success() => null,
    Error(:final failure) => failure,
  };
}
