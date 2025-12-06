import 'package:injectable/injectable.dart';
import 'package:turbovetschat/core/utils/extensions/string_extensions.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../entities/message.dart';
import '../repositories/message_repository.dart';

@injectable
class SendMessage {
  const SendMessage(this._repository);

  final MessageRepository _repository;

  Future<Result<Message>> call({
    required String chatId,
    required String senderId,
    String? content,
    required MessageType type,
    required List<String>? media,
    required bool isSelf,
  }) async {
    if (chatId.isEmpty) {
      return Result.failure(const FailedToSendMessageFailure());
    }

    if (senderId.isEmpty) {
      return Result.failure(const FailedToSendMessageFailure());
    }

    if (type == MessageType.text &&
        (content == null || content.trim().isEmpty)) {
      return Result.failure(const FailedToSendMessageFailure());
    }

    if (type == MessageType.image && (media == null || media.isEmpty)) {
      return Result.failure(const FailedToSendMessageFailure());
    }

    final messageId = const Uuid().v4();
    final timestamp = DateTime.now();

    final message = Message(
      id: messageId,
      chatId: chatId,
      senderId: senderId,
      content: content.orEmpty().trim(),
      type: type,
      timestamp: timestamp,
      isSelf: isSelf,
      status: MessageStatus.sent,
      media: media ?? const [],
    );

    if (!message.isValid) {
      return Result.failure(const FailedToSendMessageFailure());
    }

    return _repository.sendMessage(message: message);
  }
}
