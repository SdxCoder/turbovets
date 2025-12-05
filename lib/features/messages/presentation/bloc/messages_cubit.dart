import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:turbovetschat/features/messages/domain/usecases/mark_messages_as_read.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../domain/entities/message.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/usecases/watch_messages.dart';
import 'messages_state.dart';

@injectable
class MessagesCubit extends Cubit<MessagesState> {
  MessagesCubit(
    this._getChatById,
    this._sendMessage,
    this._watchMessages,
    this._markMessagesAsRead,
  ) : super(MessagesState.initial());

  final GetChatById _getChatById;
  final SendMessage _sendMessage;
  final WatchMessages _watchMessages;
  final MarkMessagesAsRead _markMessagesAsRead;
  StreamSubscription<List<Message>>? _messagesSubscription;

  Future<void> getChatById(String chatId) async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _getChatById(chatId: chatId);
    emit(state.copyWith(isLoading: false));

    switch (result) {
      case Success(:final data):
        emit(state.copyWith(chat: data, isLoading: false, failure: null));
        _startWatchingMessages(chatId);
      case Error(:final failure):
        emit(state.copyWith(failure: failure));
    }
  }

  Future<void> markMessagesAsRead(String chatId) async {
    await _markMessagesAsRead(chatId: chatId);
  }

  void _startWatchingMessages(String chatId) {
    _messagesSubscription?.cancel();
    _messagesSubscription = _watchMessages(chatId: chatId).listen(
      (messages) {
        emit(
          state.copyWith(messages: messages, failure: null, chat: state.chat),
        );
      },
      onError: (error) {
        emit(state.copyWith(failure: UnknownFailure()));
      },
    );
  }

  Future<void> sendTextMessage({
    required String chatId,
    required String senderId,
    required String content,
    required bool isSelf,
  }) async {
    emit(state.copyWith(isSending: true, failure: null));
    final result = await _sendMessage(
      chatId: chatId,
      senderId: senderId,
      content: content,
      type: MessageType.text,
      media: null,
      isSelf: isSelf,
    );
    emit(state.copyWith(isSending: false));

    switch (result) {
      case Success():
        break;
      case Error(:final failure):
        emit(state.copyWith(failure: failure));
    }
  }

  Future<void> sendImageMessage({
    required String chatId,
    required String senderId,
    required List<String> media,
    String? content,
    required bool isSelf,
  }) async {
    emit(state.copyWith(isSending: true, failure: null));
    final result = await _sendMessage(
      chatId: chatId,
      senderId: senderId,
      content: content,
      type: MessageType.image,
      media: media,
      isSelf: isSelf,
    );
    emit(state.copyWith(isSending: false));

    switch (result) {
      case Success():
        // Stream will automatically update messages
        break;
      case Error(:final failure):
        emit(state.copyWith(failure: failure));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
