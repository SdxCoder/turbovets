part of 'package:turbovetschat/core/errors/failures.dart';

sealed class ChatFailure extends Failure {
  const ChatFailure({super.code});
}

final class ChatAlreadyExistsFailure extends ChatFailure {
  const ChatAlreadyExistsFailure() : super(code: 'CHAT_ALREADY_EXISTS');
}

final class ChatNotFoundFailure extends ChatFailure {
  const ChatNotFoundFailure() : super(code: 'CHAT_NOT_FOUND');
}

final class AgentNotFoundFailure extends ChatFailure {
  const AgentNotFoundFailure() : super(code: 'AGENT_NOT_FOUND');
}

final class AgentsNotInitializedFailure extends ChatFailure {
  const AgentsNotInitializedFailure() : super(code: 'AGENTS_NOT_INITIALIZED');
}
