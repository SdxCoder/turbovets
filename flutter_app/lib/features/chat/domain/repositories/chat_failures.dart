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

final class FailedToStartChatFailure extends ChatFailure {
  const FailedToStartChatFailure() : super(code: 'FAILED_TO_START_CHAT');
}
