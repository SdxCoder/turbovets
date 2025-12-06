/// Bool extensions for nullable safety
extension BoolExtensions on bool? {
  /// Returns false if null
  bool orFalse() => this ?? false;

  /// Returns true if null
  bool orTrue() => this ?? true;
}
