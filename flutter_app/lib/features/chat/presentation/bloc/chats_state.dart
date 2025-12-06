import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat.dart';

class ChatsState extends Equatable {
  const ChatsState({
    this.chats = const [],
    this.isLoading = false,
    this.isCreatingChat = false,
    this.failure,
  });

  final List<Chat> chats;
  final bool isLoading;
  final bool isCreatingChat;
  final Failure? failure;

  factory ChatsState.initial() {
    return const ChatsState();
  }

  ChatsState copyWith({
    List<Chat>? chats,
    bool? isLoading,
    bool? isCreatingChat,
    Failure? failure,
  }) {
    return ChatsState(
      chats: chats ?? this.chats,
      isLoading: isLoading ?? this.isLoading,
      failure: failure,
      isCreatingChat: isCreatingChat ?? this.isCreatingChat,
    );
  }

  @override
  List<Object?> get props => [chats, isLoading, isCreatingChat, failure];
}
