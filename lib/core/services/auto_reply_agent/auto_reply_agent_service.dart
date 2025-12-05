import 'dart:math';

import 'exceptions.dart';

class AutoReplyAgentService {
  AutoReplyAgentService._();

  static AutoReplyAgentService? _singleton;
  static AutoReplyAgentService get instance {
    _singleton ??= AutoReplyAgentService._();
    return _singleton!;
  }

  List<String> _replyMessages = const [];
  Duration _replyDelay = const Duration(seconds: 2);
  bool _isInitialized = false;

  void initialize({required List<String> replyMessages, Duration? replyDelay}) {
    if (replyMessages.isEmpty) {
      throw const AutoReplyAgentNoMessagesException(
        'Reply messages list cannot be empty',
      );
    }

    _replyMessages = replyMessages;
    _replyDelay = replyDelay ?? const Duration(seconds: 2);
    _isInitialized = true;
  }

  bool get isInitialized => _isInitialized;

  Duration get replyDelay => _replyDelay;

  Future<String> getRandomReply() async {
    if (!_isInitialized) {
      throw const AutoReplyAgentNotInitializedException(
        'AutoReplyAgentService not initialized. Call initialize() first.',
      );
    }

    if (_replyMessages.isEmpty) {
      throw const AutoReplyAgentNoMessagesException(
        'No reply messages available',
      );
    }

    await Future.delayed(_replyDelay);

    final random = Random();
    final randomIndex = random.nextInt(_replyMessages.length);
    return _replyMessages[randomIndex];
  }

  void updateDelay(Duration delay) {
    if (!_isInitialized) {
      throw const AutoReplyAgentNotInitializedException(
        'AutoReplyAgentService not initialized. Call initialize() first.',
      );
    }
    _replyDelay = delay;
  }
}
