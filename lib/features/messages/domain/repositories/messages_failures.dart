part of 'package:turbovetschat/core/errors/failures.dart';

sealed class MessageFailure extends Failure {
  const MessageFailure({super.code});
}

final class FailedToSendMessageFailure extends MessageFailure {
  const FailedToSendMessageFailure() : super(code: 'FAILED_TO_SEND_MESSAGE');
}

final class FailedToGetMessagesFailure extends MessageFailure {
  const FailedToGetMessagesFailure() : super(code: 'FAILED_TO_GET_MESSAGES');
}

final class NoImagesSelectedFailure extends MessageFailure {
  const NoImagesSelectedFailure() : super(code: 'NO_IMAGES_SELECTED');
}
