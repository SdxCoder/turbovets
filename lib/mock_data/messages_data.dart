import 'message.dart';

class MessagesData {
  static List<MockMessage> get messages {
    final now = DateTime.now();
    final threePM = DateTime(now.year, now.month, now.day, 15, 0);
    final threePMPlus5 = threePM.add(const Duration(minutes: 5));
    final threePMPlus10 = threePM.add(const Duration(minutes: 10));
    final threePMPlus15 = threePM.add(const Duration(minutes: 15));
    final threePMPlus20 = threePM.add(const Duration(minutes: 20));
    final threePMPlus25 = threePM.add(const Duration(minutes: 25));
    final threePMPlus30 = threePM.add(const Duration(minutes: 30));
    final threePMPlus35 = threePM.add(const Duration(minutes: 35));
    final threePMPlus40 = threePM.add(const Duration(minutes: 40));
    final threePMPlus45 = threePM.add(const Duration(minutes: 45));
    final threePMPlus50 = threePM.add(const Duration(minutes: 50));

    return [
      MockMessage(
        id: '1',
        senderId: 'user',
        timestamp: threePM,
        text: 'Who was that photographer you shared with me recently?',
        senderImageUrl: 'https://i.pravatar.cc/150?img=12',
      ),
      MockMessage(
        id: '2',
        senderId: 'agent',
        timestamp: threePMPlus5,
        text: 'Slim Aarons',
      ),
      MockMessage(
        id: '3',
        senderId: 'user',
        timestamp: threePMPlus10,
        text: 'What was his vision statement?',
        senderImageUrl: 'https://i.pravatar.cc/150?img=12',
      ),
      MockMessage(
        id: '4',
        senderId: 'agent',
        timestamp: threePMPlus15,
        text: 'That\'s him!',
      ),
      MockMessage(
        id: '5',
        senderId: 'agent',
        timestamp: threePMPlus20,
        text:
            '"Attractive people doing attractive things in attractive places"',
      ),
      MockMessage(
        id: '6',
        senderId: 'agent',
        timestamp: threePMPlus25,
        images: [
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
          'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=400',
        ],
      ),
      MockMessage(
        id: '7',
        senderId: 'user',
        timestamp: threePMPlus30,
        text: 'Here\'s a single image I wanted to share',
        senderImageUrl: 'https://i.pravatar.cc/150?img=12',
        images: [
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
        ],
      ),
      MockMessage(
        id: '8',
        senderId: 'user',
        timestamp: threePMPlus35,
        senderImageUrl: 'https://i.pravatar.cc/150?img=12',
        images: [
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
        ],
      ),
      MockMessage(
        id: '9',
        senderId: 'agent',
        timestamp: threePMPlus40,
        text: 'Beautiful!',
      ),
      MockMessage(
        id: '10',
        senderId: 'user',
        timestamp: threePMPlus45,
        text: 'Here are two images from my trip',
        senderImageUrl: 'https://i.pravatar.cc/150?img=12',
        images: [
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
        ],
      ),
      MockMessage(
        id: '11',
        senderId: 'user',
        timestamp: threePMPlus50,
        senderImageUrl: 'https://i.pravatar.cc/150?img=12',
        images: [
          'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=400',
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
          'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=400',
          'https://images.unsplash.com/photo-1519046904884-53103b34b206?w=400',
        ],
      ),
    ];
  }
}
