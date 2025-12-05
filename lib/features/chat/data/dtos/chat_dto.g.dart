// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatDto _$ChatDtoFromJson(Map<String, dynamic> json) => ChatDto(
  id: json['id'] as String?,
  user: json['user'] == null
      ? null
      : UserDto.fromJson(json['user'] as Map<String, dynamic>),
  agent: json['agent'] == null
      ? null
      : AgentDto.fromJson(json['agent'] as Map<String, dynamic>),
  lastMessageTimestamp: json['last_message_timestamp'] as String?,
  unreadCount: (json['unread_count'] as num?)?.toInt(),
);

Map<String, dynamic> _$ChatDtoToJson(ChatDto instance) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user,
  'agent': instance.agent,
  'last_message_timestamp': instance.lastMessageTimestamp,
  'unread_count': instance.unreadCount,
};
