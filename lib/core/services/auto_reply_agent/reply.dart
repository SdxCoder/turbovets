class AutoReply {
  const AutoReply({
    required this.type,
    this.content = '',
    this.media = const [],
  });

  final AutoReplyType type;
  final String content;
  final List<String> media;

  bool get isValid {
    switch (type) {
      case AutoReplyType.text:
        return content.isNotEmpty;
      case AutoReplyType.image:
        return media.isNotEmpty;
      case AutoReplyType.mixed:
        return media.isNotEmpty;
    }
  }
}

enum AutoReplyType { text, image, mixed }
