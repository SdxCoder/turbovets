import 'package:injectable/injectable.dart';
import 'package:turbovetschat/core/errors/failures.dart';
import 'package:turbovetschat/features/agents/domain/entities/agent.dart';

import '../../../../core/errors/result.dart';
import '../../../auth/domain/entities/user.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

@injectable
class CreateChat {
  const CreateChat(this._chatRepository, this._authRepository);

  final ChatRepository _chatRepository;
  final AuthRepository _authRepository;

  Future<Result<Chat>> call({required Agent agent}) async {
    if (!agent.isValid) return Result.failure(const FailedToStartChatFailure());

    final result = await _authRepository.getCurrentUser();
    if (result.isError) return Result.failure(const FailedToStartChatFailure());

    final user = result.when(success: (d) => d, error: (e) => User.empty());
    if (!user.isValid) return Result.failure(const FailedToStartChatFailure());

    final createChatResult = await _chatRepository.createChat(
      agent: agent,
      user: user,
    );
    if (createChatResult.failureOrNull != null &&
        createChatResult.failureOrNull is ChatAlreadyExistsFailure) {
      return _chatRepository.getChatByUserAndAgentId(user.id, agent.id);
    }

    return createChatResult;
  }
}
