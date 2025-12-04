import 'chat.dart';

class ChatsData {
  static List<MockChat> get chats {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day, 14, 14);
    final todayEvening = DateTime(now.year, now.month, now.day, 22, 16);
    final yesterday = today.subtract(const Duration(days: 1));
    final threeDaysAgo = today.subtract(const Duration(days: 3));
    final fiveDaysAgo = today.subtract(const Duration(days: 5));
    final sixDaysAgo = today.subtract(const Duration(days: 6));
    final eightDaysAgo = today.subtract(const Duration(days: 8));

    return [
      MockChat(
        id: '1',
        imageUrl: 'https://i.pravatar.cc/150?img=12',
        name: 'Daniel Atkins',
        lastMessage: 'The weather will be perfect for the st...',
        timestamp: today.toIso8601String(),
        unreadCount: 1,
        isRead: true,
      ),
      MockChat(
        id: '2',
        imageUrl: 'https://i.pravatar.cc/150?img=13',
        name: 'Erin, Ursula, Matthew',
        lastMessage: 'You: The store only has (gasp!) 2% m...',
        timestamp: todayEvening.toIso8601String(),
        unreadCount: 1,
        isRead: true,
      ),
      MockChat(
        id: '3',
        imageUrl: 'https://i.pravatar.cc/150?img=14',
        name: 'Baker Mayfield',
        lastMessage: 'Sounds good!',
        timestamp: yesterday.toIso8601String(),
        unreadCount: 0,
        isRead: false,
      ),
      MockChat(
        id: '4',
        imageUrl: 'https://i.pravatar.cc/150?img=15',
        name: 'Photographers',
        lastMessage: 'New photos uploaded!',
        timestamp: threeDaysAgo.toIso8601String(),
        unreadCount: 80,
        isRead: false,
      ),
      MockChat(
        id: '5',
        imageUrl: 'https://i.pravatar.cc/150?img=16',
        name: 'Regina Jones',
        lastMessage: 'Thanks for the update!',
        timestamp: fiveDaysAgo.toIso8601String(),
        unreadCount: 0,
        isRead: true,
      ),
      MockChat(
        id: '6',
        imageUrl: 'https://i.pravatar.cc/150?img=17',
        name: 'Nelms, Clayton, Wagner, Morgan',
        lastMessage: 'Meeting scheduled for tomorrow',
        timestamp: sixDaysAgo.toIso8601String(),
        unreadCount: 0,
        isRead: false,
      ),
      MockChat(
        id: '7',
        imageUrl: 'https://i.pravatar.cc/150?img=18',
        name: 'Kaitlyn Henson',
        lastMessage: 'See you there!',
        timestamp: eightDaysAgo.toIso8601String(),
        unreadCount: 0,
        isRead: true,
      ),
    ];
  }
}
