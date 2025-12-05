import 'package:equatable/equatable.dart';

enum MessageType { text, image }

enum MessageStatus { sent, read }

class Message extends Equatable {
  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    required this.type,
    required this.timestamp,
    required this.isSelf,
    required this.status,
    this.media = const [],
  });

  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final bool isSelf;
  final MessageStatus status;
  final List<String> media;

  bool get isValid =>
      id.isNotEmpty &&
      chatId.isNotEmpty &&
      senderId.isNotEmpty &&
      (type == MessageType.text || media.isNotEmpty);

  Message copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? content,
    MessageType? type,
    DateTime? timestamp,
    bool? isSelf,
    MessageStatus? status,
    List<String>? media,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isSelf: isSelf ?? this.isSelf,
      status: status ?? this.status,
      media: media ?? this.media,
    );
  }

  @override
  List<Object?> get props => [
    id,
    chatId,
    senderId,
    content,
    type,
    timestamp,
    isSelf,
    status,
    media,
  ];
}
