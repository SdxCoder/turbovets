class MockMessage {
  const MockMessage({
    required this.id,
    required this.senderId,
    required this.timestamp,
    this.text,
    this.images,
    this.senderImageUrl,
  });

  final String id;
  final String senderId;
  final DateTime timestamp;
  final String? text;
  final List<String>? images;
  final String? senderImageUrl;
}
