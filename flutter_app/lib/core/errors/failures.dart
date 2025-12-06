import 'package:equatable/equatable.dart';

part '../../features/auth/domain/repositories/auth_failures.dart';
part '../../features/chat/domain/repositories/chat_failures.dart';
part '../../features/messages/domain/repositories/messages_failures.dart';

/// Base class for all failures in the app
/// Uses sealed classes for exhaustive pattern matching
sealed class Failure extends Equatable {
  const Failure({this.code});

  final String? code;

  @override
  List<Object?> get props => [code];
}

/// Cache/local storage failures
sealed class CacheFailure extends Failure {
  const CacheFailure({super.code});
}

class CacheReadFailure extends CacheFailure {
  const CacheReadFailure() : super(code: 'CACHE_READ_FAILURE');
}

class CacheWriteFailure extends CacheFailure {
  const CacheWriteFailure() : super(code: 'CACHE_WRITE_FAILURE');
}

/// Unknown/unexpected failures
class UnknownFailure extends Failure {
  const UnknownFailure() : super(code: 'UNKNOWN_FAILURE');
}

class ImagePickPermissionDeniedFailure extends Failure {
  const ImagePickPermissionDeniedFailure()
    : super(code: 'IMAGE_PICK_PERMISSION_DENIED');
}

class ImagePickPlatformFailure extends Failure {
  const ImagePickPlatformFailure() : super(code: 'IMAGE_PICK_PLATFORM_FAILURE');
}

class ImagePickCancelledFailure extends Failure {
  const ImagePickCancelledFailure() : super(code: 'IMAGE_PICK_CANCELLED');
}
