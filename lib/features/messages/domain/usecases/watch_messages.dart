import 'package:injectable/injectable.dart';

import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';

@injectable
class WatchMessages {
  const WatchMessages(this._repository);

  final MessageRepository _repository;

  Stream<List<Message>> call({required String chatId}) {
    return _repository.watchMessages(chatId);
  }
}
