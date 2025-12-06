import 'package:equatable/equatable.dart';

import '../../../agents/domain/entities/agent.dart';
import '../../../auth/domain/entities/user.dart';
import '../value_objects/chat_timestamp.dart';

class Chat extends Equatable {
  Chat.empty()
    : this(
        id: '',
        user: const User.empty(),
        agent: const Agent.empty(),
        lastMessageTimestamp: ChatTimestamp(),
        unreadCount: 0,
      );

  const Chat({
    required this.id,
    required this.user,
    required this.agent,
    required this.lastMessageTimestamp,
    required this.unreadCount,
  });

  final String id;
  final User user;
  final Agent agent;
  final ChatTimestamp lastMessageTimestamp;
  final int unreadCount;

  bool get isValid => id.isNotEmpty && user.isValid && agent.isValid;

  bool get isRead => unreadCount == 0;

  Chat copyWith({
    String? id,
    User? user,
    Agent? agent,
    bool? isRead,
    ChatTimestamp? lastMessageTimestamp,
    int? unreadCount,
  }) {
    return Chat(
      id: id ?? this.id,
      user: user ?? this.user,
      agent: agent ?? this.agent,
      lastMessageTimestamp: lastMessageTimestamp ?? this.lastMessageTimestamp,
      unreadCount: unreadCount ?? this.unreadCount,
    );
  }

  @override
  List<Object?> get props => [
    id,
    user,
    agent,
    isRead,
    lastMessageTimestamp,
    unreadCount,
  ];
}
