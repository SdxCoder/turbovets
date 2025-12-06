import 'dart:math';

import 'exceptions.dart';
import 'reply.dart';

class AutoReplyAgentService {
  AutoReplyAgentService._();

  static AutoReplyAgentService? _singleton;
  static AutoReplyAgentService get instance {
    _singleton ??= AutoReplyAgentService._();
    return _singleton!;
  }

  List<String> _replyMessages = const [];
  List<String> _imageUrls = const [];
  Duration _replyDelay = const Duration(seconds: 2);
  bool _isInitialized = false;

  void initialize({
    List<String>? replyMessages,
    List<String>? imageUrls,
    Duration? replyDelay,
  }) {
    if ((replyMessages == null || replyMessages.isEmpty) &&
        (imageUrls == null || imageUrls.isEmpty)) {
      throw const AutoReplyAgentNoMessagesException(
        'Reply messages or image URLs list cannot be empty',
      );
    }

    _replyMessages = replyMessages ?? const [];
    _imageUrls = imageUrls ?? const [];
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

  Future<AutoReply> getRandomAutoReply({String? userMessage}) async {
    if (!_isInitialized) {
      throw const AutoReplyAgentNotInitializedException(
        'AutoReplyAgentService not initialized. Call initialize() first.',
      );
    }

    if (_replyMessages.isEmpty && _imageUrls.isEmpty) {
      throw const AutoReplyAgentNoMessagesException(
        'No reply messages or images available',
      );
    }

    await Future.delayed(_replyDelay);

    final random = Random();
    final replyType = _analyzeUserMessage(userMessage, random);

    switch (replyType) {
      case AutoReplyType.text:
        if (_replyMessages.isEmpty) {
          return await getRandomAutoReply(userMessage: userMessage);
        }
        final textIndex = random.nextInt(_replyMessages.length);
        return AutoReply(
          type: AutoReplyType.text,
          content: _replyMessages[textIndex],
        );

      case AutoReplyType.image:
        if (_imageUrls.isEmpty) {
          return await getRandomAutoReply(userMessage: userMessage);
        }
        final imageCount = _extractImageCountFromMessage(userMessage, random);
        final selectedImages = _getRandomImages(random, imageCount);
        return AutoReply(type: AutoReplyType.image, media: selectedImages);

      case AutoReplyType.mixed:
        if (_replyMessages.isEmpty || _imageUrls.isEmpty) {
          return await getRandomAutoReply(userMessage: userMessage);
        }
        final textIndex = random.nextInt(_replyMessages.length);
        final imageCount = _extractImageCountFromMessage(userMessage, random);
        final selectedImages = _getRandomImages(random, imageCount);
        return AutoReply(
          type: AutoReplyType.mixed,
          content: _replyMessages[textIndex],
          media: selectedImages,
        );
    }
  }

  AutoReplyType _analyzeUserMessage(String? userMessage, Random random) {
    if (userMessage == null || userMessage.trim().isEmpty) {
      return _getRandomReplyType(random);
    }

    final lowerMessage = userMessage.toLowerCase();
    final hasImageKeyword =
        lowerMessage.contains('image') ||
        lowerMessage.contains('picture') ||
        lowerMessage.contains('photo') ||
        lowerMessage.contains('pic');

    if (hasImageKeyword) {
      if (_imageUrls.isEmpty) {
        return AutoReplyType.text;
      }
      if (_replyMessages.isEmpty) {
        return AutoReplyType.image;
      }
      return AutoReplyType.mixed;
    }

    return AutoReplyType.text;
  }

  int _extractImageCountFromMessage(String? userMessage, Random random) {
    if (userMessage == null || userMessage.trim().isEmpty) {
      return _getRandomImageCount(random);
    }

    final lowerMessage = userMessage.toLowerCase();
    final regex = RegExp(r'\b(\d+)\s*(?:image|picture|photo|pic)s?\b');
    final match = regex.firstMatch(lowerMessage);

    if (match != null) {
      final count = int.tryParse(match.group(1) ?? '');
      if (count != null && count > 0) {
        return min(count, _imageUrls.length);
      }
    }

    return _getRandomImageCount(random);
  }

  AutoReplyType _getRandomReplyType(Random random) {
    final hasText = _replyMessages.isNotEmpty;
    final hasImages = _imageUrls.isNotEmpty;

    if (!hasText && hasImages) {
      return AutoReplyType.image;
    }
    if (hasText && !hasImages) {
      return AutoReplyType.text;
    }

    final typeValue = random.nextInt(3);
    return switch (typeValue) {
      0 => AutoReplyType.text,
      1 => AutoReplyType.image,
      _ => AutoReplyType.mixed,
    };
  }

  int _getRandomImageCount(Random random) {
    final availableCount = _imageUrls.length;
    if (availableCount == 0) return 0;
    if (availableCount == 1) return 1;

    final countValue = random.nextInt(100);
    if (countValue < 40) {
      return 1;
    } else if (countValue < 70) {
      return 2;
    } else if (countValue < 85) {
      return 3;
    } else {
      return min(4, availableCount);
    }
  }

  List<String> _getRandomImages(Random random, int count) {
    if (count == 0 || _imageUrls.isEmpty) return [];
    if (count >= _imageUrls.length) {
      return List.from(_imageUrls);
    }

    final shuffled = List<String>.from(_imageUrls)..shuffle(random);
    return shuffled.take(count).toList();
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
