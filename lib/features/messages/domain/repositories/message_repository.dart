import 'dart:async';

import '../../../../core/errors/result.dart';
import '../entities/message.dart';

abstract class MessageRepository {
  Stream<List<Message>> watchMessages(String chatId);
  Future<Result<Message>> sendMessage({required Message message});
  Future<void> markMessagesAsRead({required String chatId});
}
