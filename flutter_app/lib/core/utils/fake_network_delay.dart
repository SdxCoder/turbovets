class FakeNetworkDelay {
  static const Duration _delay = Duration(seconds: 1);

  static Future<void> delay() => Future.delayed(_delay);
}
