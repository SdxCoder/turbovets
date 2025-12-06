import 'package:injectable/injectable.dart';

import '../../domain/entities/chat.dart';
import '../../domain/repositories/chat_repository.dart';

@injectable
class WatchChats {
  const WatchChats(this._repository);

  final ChatRepository _repository;

  Stream<List<Chat>> call(String currentUserId) {
    return _repository.watchChats(currentUserId);
  }
}
