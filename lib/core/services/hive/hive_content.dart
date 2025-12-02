sealed class HiveContent {
  final String key;

  const HiveContent({required this.key});

  factory HiveContent.integer({required String key, required int value}) =>
      _StorageIntValue(key: key, data: value);

  factory HiveContent.double({required String key, required double value}) =>
      _StorageDoubleValue(key: key, data: value);

  factory HiveContent.bool({required String key, required bool value}) =>
      _StorageBoolValue(key: key, data: value);

  factory HiveContent.string({required String key, required String value}) =>
      _StorageStringValue(key: key, data: value);

  factory HiveContent.map({
    required String key,
    required Map<String, dynamic> value,
  }) => _StorageMapValue(key: key, data: value);

  factory HiveContent.listMap({
    required String key,
    required List<Map<String, dynamic>> value,
  }) => _StorageListMapValue(key: key, data: value);
}

final class _StorageIntValue extends HiveContent {
  final int data;

  _StorageIntValue({required super.key, required this.data});
}

final class _StorageDoubleValue extends HiveContent {
  final double data;

  _StorageDoubleValue({required this.data, required super.key});
}

final class _StorageBoolValue extends HiveContent {
  final bool data;

  _StorageBoolValue({required this.data, required super.key});
}

final class _StorageStringValue extends HiveContent {
  final String data;

  _StorageStringValue({required this.data, required super.key});
}

final class _StorageMapValue extends HiveContent {
  final Map<String, dynamic> data;

  _StorageMapValue({required this.data, required super.key});
}

final class _StorageListMapValue extends HiveContent {
  final List<Map<String, dynamic>> data;

  _StorageListMapValue({required this.data, required super.key});
}

extension HiveContentX on HiveContent {
  void when({
    required Function(String key, int value) integer,
    required Function(String key, double value) double,
    required Function(String key, bool value) bool,
    required Function(String key, String value) string,
    required Function(String key, Map<String, dynamic> value) map,
    required Function(String key, List<Map<String, dynamic>> value) listMap,
  }) {
    switch (this) {
      case _StorageIntValue(:final key, :final data):
        integer(key, data);
      case _StorageDoubleValue(:final key, :final data):
        double(key, data);
      case _StorageBoolValue(:final key, :final data):
        bool(key, data);
      case _StorageStringValue(:final key, :final data):
        string(key, data);
      case _StorageMapValue(:final key, :final data):
        map(key, data);
      case _StorageListMapValue(:final key, :final data):
        listMap(key, data);
    }
  }
}
