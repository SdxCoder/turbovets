class MockChat {
  const MockChat({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    required this.isRead,
  });

  final String id;
  final String imageUrl;
  final String name;
  final String lastMessage;
  final String timestamp;
  final int unreadCount;
  final bool isRead;
}
