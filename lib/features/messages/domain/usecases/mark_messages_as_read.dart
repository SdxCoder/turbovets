import 'package:injectable/injectable.dart';

import '../repositories/message_repository.dart';

@injectable
class MarkMessagesAsRead {
  const MarkMessagesAsRead(this._repository);

  final MessageRepository _repository;

  Future<void> call({required String chatId}) async {
    return _repository.markMessagesAsRead(chatId: chatId);
  }
}
