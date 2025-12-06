// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageDto _$MessageDtoFromJson(Map<String, dynamic> json) => MessageDto(
  id: json['id'] as String?,
  chatId: json['chat_id'] as String?,
  senderId: json['sender_id'] as String?,
  content: json['content'] as String?,
  type: json['type'] as String?,
  timestamp: json['timestamp'] as String?,
  isSelf: json['is_self'] as bool?,
  status: json['status'] as String?,
  media: (json['media'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$MessageDtoToJson(MessageDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'chat_id': instance.chatId,
      'sender_id': instance.senderId,
      'content': instance.content,
      'type': instance.type,
      'timestamp': instance.timestamp,
      'is_self': instance.isSelf,
      'status': instance.status,
      'media': instance.media,
    };
