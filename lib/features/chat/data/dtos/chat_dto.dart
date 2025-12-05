import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/extensions/int_extensions.dart';
import '../../../../core/utils/extensions/string_extensions.dart';
import '../../../agents/data/dtos/agent_dto.dart';
import '../../../agents/domain/entities/agent.dart';
import '../../../auth/data/dtos/user_dto.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/chat.dart';

part 'chat_dto.g.dart';

@JsonSerializable()
class ChatDto {
  const ChatDto({
    this.id,
    this.user,
    this.agent,
    this.isRead,
    this.lastMessageTimestamp,
    this.unreadCount,
  });

  final String? id;
  final UserDto? user;
  final AgentDto? agent;
  @JsonKey(name: 'is_read')
  final bool? isRead;
  @JsonKey(name: 'last_message_timestamp')
  final String? lastMessageTimestamp;
  @JsonKey(name: 'unread_count')
  final int? unreadCount;

  factory ChatDto.fromJson(Map<String, dynamic> json) =>
      _$ChatDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDtoToJson(this);
}

extension ChatDtoX on ChatDto {
  Chat toDomain() {
    return Chat(
      id: id.orCrash('id'),
      user: user?.toDomain() ?? User.empty(),
      agent:
          agent?.toDomain() ??
          Agent(id: '', imageUrl: '', name: '', description: ''),
      isRead: isRead ?? false,
      lastMessageTimestamp: lastMessageTimestamp != null
          ? DateTime.tryParse(lastMessageTimestamp!)
          : null,
      unreadCount: unreadCount.orZero(),
    );
  }
}

extension ChatX on Chat {
  ChatDto toDto() {
    return ChatDto(
      id: id,
      user: user.toDto(),
      agent: agent.toDto(),
      isRead: isRead,
      lastMessageTimestamp: lastMessageTimestamp?.toIso8601String(),
      unreadCount: unreadCount,
    );
  }
}
