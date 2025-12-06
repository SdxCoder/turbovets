import 'dart:convert';

import 'package:crypto/crypto.dart';

class PasswordHasher {
  PasswordHasher._();

  /// Hash a password using SHA-256
  static String hash(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static bool verify(String password, String hash) {
    return PasswordHasher.hash(password) == hash;
  }
}
