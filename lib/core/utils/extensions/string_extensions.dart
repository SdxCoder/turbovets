/// String extensions for nullable safety
extension StringExtensions on String? {
  /// Returns empty string if null
  String orEmpty() => this ?? '';

  /// Crashes app if null (for required fields in DTOs)
  String orCrash(String fieldName) {
    if (this == null) {
      throw Exception('Required field "$fieldName" is null');
    }
    return this!;
  }

  /// Check if null or empty
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Check if not null and not empty
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// Check if null
  bool get isNull => this == null;
}
