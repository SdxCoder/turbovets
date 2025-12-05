import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../../chat/domain/entities/chat.dart';
import '../../../chat/domain/repositories/chat_repository.dart';
import '../entities/message.dart';

typedef MessagesData = ({Chat chat, List<Message> messages});

@injectable
class GetChatById {
  const GetChatById(this._chatRepository);

  final ChatRepository _chatRepository;

  Future<Result<Chat>> call({required String chatId}) async {
    if (chatId.isEmpty) {
      return Result.failure(const FailedToGetMessagesFailure());
    }

    return _chatRepository.getChatById(chatId);
  }
}
