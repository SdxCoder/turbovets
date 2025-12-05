import 'dart:async';

import 'package:turbovetschat/features/agents/domain/entities/agent.dart';
import 'package:turbovetschat/features/auth/domain/entities/user.dart';

import '../../../../core/errors/result.dart';
import '../entities/chat.dart';

abstract class ChatRepository {
  Future<Result<Chat>> createChat({required User user, required Agent agent});
  Stream<List<Chat>> watchChats();
  Future<Result<Chat>> getChatById(String chatId);
  Future<Result<Chat>> getChatByUserAndAgentId(String userId, String agentId);
}
