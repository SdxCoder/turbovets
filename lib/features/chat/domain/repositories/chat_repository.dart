import '../../../../core/errors/result.dart';
import '../entities/chat.dart';

abstract class ChatRepository {
  Future<Result<Chat>> createChat({
    required String userId,
    required String agentId,
  });
  Future<Result<List<Chat>>> getChats();
  Future<Result<Chat>> getChatById(String chatId);
}
