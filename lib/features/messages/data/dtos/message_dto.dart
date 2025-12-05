import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/extensions/string_extensions.dart';
import '../../domain/entities/message.dart';

part 'message_dto.g.dart';

@JsonSerializable()
class MessageDto {
  const MessageDto({
    this.id,
    this.chatId,
    this.senderId,
    this.content,
    this.type,
    this.timestamp,
    this.isSelf,
    this.status,
    this.media,
  });

  final String? id;
  @JsonKey(name: 'chat_id')
  final String? chatId;
  @JsonKey(name: 'sender_id')
  final String? senderId;
  final String? content;
  final String? type;
  final String? timestamp;
  @JsonKey(name: 'is_self')
  final bool? isSelf;
  final String? status;
  final List<String>? media;

  factory MessageDto.fromJson(Map<String, dynamic> json) =>
      _$MessageDtoFromJson(json);

  Map<String, dynamic> toJson() => _$MessageDtoToJson(this);
}

extension MessageDtoX on MessageDto {
  Message toDomain() {
    return Message(
      id: id.orCrash('id'),
      chatId: chatId.orCrash('chatId'),
      senderId: senderId.orCrash('senderId'),
      content: content.orEmpty(),
      type: _parseMessageType(type),
      timestamp: timestamp != null
          ? DateTime.tryParse(timestamp!) ?? DateTime.now()
          : DateTime.now(),
      isSelf: isSelf ?? false,
      status: _parseMessageStatus(status),
      media: media ?? const [],
    );
  }

  MessageType _parseMessageType(String? type) {
    if (type == null) return MessageType.text;
    return switch (type.toLowerCase()) {
      'text' => MessageType.text,
      'image' => MessageType.image,
      _ => MessageType.text,
    };
  }

  MessageStatus _parseMessageStatus(String? status) {
    if (status == null) return MessageStatus.sent;
    return switch (status.toLowerCase()) {
      'sent' => MessageStatus.sent,
      'read' => MessageStatus.read,
      _ => MessageStatus.sent,
    };
  }
}

extension MessageX on Message {
  MessageDto toDto() {
    return MessageDto(
      id: id,
      chatId: chatId,
      senderId: senderId,
      content: content,
      type: _typeToString(type),
      timestamp: timestamp.toIso8601String(),
      isSelf: isSelf,
      status: _statusToString(status),
      media: media.isEmpty ? null : media,
    );
  }

  String _typeToString(MessageType type) {
    return switch (type) {
      MessageType.text => 'text',
      MessageType.image => 'image',
    };
  }

  String _statusToString(MessageStatus status) {
    return switch (status) {
      MessageStatus.sent => 'sent',
      MessageStatus.read => 'read',
    };
  }
}
