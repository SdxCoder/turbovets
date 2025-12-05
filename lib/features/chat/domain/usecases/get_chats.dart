import 'package:injectable/injectable.dart';

import '../../../../core/errors/result.dart';
import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

@injectable
class GetChats {
  const GetChats(this._repository);

  final ChatRepository _repository;

  Future<Result<List<Chat>>> call() async {
    return _repository.getChats();
  }
}
