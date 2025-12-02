/// Base exception class
class AppException implements Exception {
  const AppException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'AppException';
}

/// Exception thrown when cache operation fails
class CacheException extends AppException {
  const CacheException([super.message]);
}
