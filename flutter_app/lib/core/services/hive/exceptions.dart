abstract class HiveException implements Exception {
  const HiveException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Hive Service Exception';
}

/// Exception thrown when Hive service is not initialized
final class CacheInitException extends HiveException {
  const CacheInitException([super.message]);
}

/// Exception thrown when cache read operation fails
final class CacheReadException extends HiveException {
  const CacheReadException([super.message]);
}

/// Exception thrown when cache write operation fails
final class CacheWriteException extends HiveException {
  const CacheWriteException([super.message]);
}
