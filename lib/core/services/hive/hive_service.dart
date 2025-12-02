import 'dart:convert';

import 'package:hive/hive.dart';

import 'exceptions.dart';
import 'hive_content.dart';

class HiveService {
  HiveService._();

  static HiveService? _singleton;
  static const String _boxName = 'app_storage';
  Box? _box;

  static HiveService get instance {
    _singleton ??= HiveService._();
    return _singleton!;
  }

  Future<void> init() async {
    if (_box != null && _box!.isOpen) {
      return;
    }

    try {
      _box = await Hive.openBox(_boxName);
    } catch (e) {
      throw CacheInitException('Failed to initialize Hive box: $e');
    }
  }

  bool get isInitialized => _box != null && _box!.isOpen;

  Box get _hiveBox {
    if (!isInitialized) {
      throw CacheInitException(
        'HiveService not initialized. Call init() first.',
      );
    }
    return _box!;
  }

  Future<void> save(HiveContent content) async {
    try {
      content.when(
        integer: _saveInHiveStorage,
        double: _saveInHiveStorage,
        bool: _saveInHiveStorage,
        string: _saveInHiveStorage,
        map: (key, value) => _saveInHiveStorage(key, jsonEncode(value)),
        listMap: (key, value) => _saveInHiveStorage(key, jsonEncode(value)),
      );
    } catch (e) {
      throw CacheWriteException('Failed to save content: $e');
    }
  }

  Future<void> _saveInHiveStorage(String key, dynamic value) async {
    await _hiveBox.put(key, value);
  }

  T? readMap<T>(
    String key, {
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    try {
      final storedValue = _hiveBox.get(key);
      if (storedValue == null) return null;
      final json = jsonDecode(storedValue) as Map<String, dynamic>?;
      return json != null ? fromJson(json) : null;
    } catch (e) {
      throw CacheReadException('Failed to read map with key "$key": $e');
    }
  }

  List<T>? readListMap<T>(
    String key, {
    required T Function(Map<String, dynamic>) fromJson,
  }) {
    try {
      final storedValue = _hiveBox.get(key);
      if (storedValue == null) return null;
      final jsonList = jsonDecode(storedValue) as List<dynamic>?;
      return jsonList
          ?.map((item) => fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw CacheReadException('Failed to read list map with key "$key": $e');
    }
  }

  /// Read primitive value (int, double, bool, String)
  T? read<T>(String key) {
    try {
      return _hiveBox.get(key) as T?;
    } catch (e) {
      throw CacheReadException('Failed to read item with key "$key": $e');
    }
  }

  Future<void> remove(String key) async {
    try {
      await _hiveBox.delete(key);
    } catch (e) {
      throw CacheWriteException('Failed to remove item with key "$key": $e');
    }
  }
}
