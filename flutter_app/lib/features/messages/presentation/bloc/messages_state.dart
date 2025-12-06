import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../chat/domain/entities/chat.dart';
import '../../domain/entities/message.dart';

class MessagesState extends Equatable {
  const MessagesState._({
    required this.chat,
    required this.messages,
    required this.isLoading,
    required this.isSending,
    required this.failure,
  });

  final Chat chat;
  final List<Message> messages;
  final bool isLoading;
  final bool isSending;
  final Failure? failure;

  factory MessagesState.initial() {
    return MessagesState._(
      chat: Chat.empty(),
      messages: [],
      isLoading: false,
      isSending: false,
      failure: null,
    );
  }

  MessagesState copyWith({
    Chat? chat,
    List<Message>? messages,
    bool? isLoading,
    bool? isSending,
    Failure? failure,
  }) {
    return MessagesState._(
      chat: chat ?? this.chat,
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isSending: isSending ?? this.isSending,
      failure: failure,
    );
  }

  @override
  List<Object?> get props => [chat, messages, isLoading, isSending, failure];
}
