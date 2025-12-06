import 'package:json_annotation/json_annotation.dart';

import '../../../../core/utils/extensions/int_extensions.dart';
import '../../../../core/utils/extensions/string_extensions.dart';
import '../../../agents/data/dtos/agent_dto.dart';
import '../../../agents/domain/entities/agent.dart';
import '../../../auth/data/dtos/user_dto.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/chat.dart';
import '../../domain/value_objects/chat_timestamp.dart';

part 'chat_dto.g.dart';

@JsonSerializable()
class ChatDto {
  const ChatDto({
    this.id,
    this.user,
    this.agent,
    this.lastMessageTimestamp,
    this.unreadCount,
  });

  final String? id;
  final UserDto? user;
  final AgentDto? agent;
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
      lastMessageTimestamp: ChatTimestamp(value: lastMessageTimestamp),
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
      lastMessageTimestamp: lastMessageTimestamp.value,
      unreadCount: unreadCount,
    );
  }
}
