/// Int extensions for nullable safety
extension IntExtensions on int? {
  /// Returns 0 if null
  int orZero() => this ?? 0;

  /// Crashes app if null (for required fields in DTOs)
  int orCrash(String fieldName) {
    if (this == null) {
      throw Exception('Required field "$fieldName" is null');
    }
    return this!;
  }
}
