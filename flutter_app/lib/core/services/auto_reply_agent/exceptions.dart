abstract class AutoReplyAgentException implements Exception {
  const AutoReplyAgentException([this.message]);

  final String? message;

  @override
  String toString() => message ?? 'Auto Reply Agent Exception';
}

final class AutoReplyAgentNotInitializedException
    extends AutoReplyAgentException {
  const AutoReplyAgentNotInitializedException([super.message]);
}

final class AutoReplyAgentNoMessagesException extends AutoReplyAgentException {
  const AutoReplyAgentNoMessagesException([super.message]);
}
