import 'package:equatable/equatable.dart';

import '../../../agents/domain/entities/agent.dart';
import '../../../auth/domain/entities/user.dart';

class Chat extends Equatable {
  const Chat({
    required this.id,
    required this.user,
    required this.agent,
    required this.isRead,
    required this.lastMessageTimestamp,
    required this.unreadCount,
  });

  final String id;
  final User user;
  final Agent agent;
  final bool isRead;
  final DateTime? lastMessageTimestamp;
  final int unreadCount;

  bool get isValid => id.isNotEmpty && user.isValid && agent.isValid;

  Chat copyWith({
    String? id,
    User? user,
    Agent? agent,
    bool? isRead,
    DateTime? lastMessageTimestamp,
    int? unreadCount,
  }) {
    return Chat(
      id: id ?? this.id,
      user: user ?? this.user,
      agent: agent ?? this.agent,
      isRead: isRead ?? this.isRead,
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
