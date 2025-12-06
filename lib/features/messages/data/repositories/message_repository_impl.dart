import 'dart:async';

import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/auto_reply_agent/index.dart';
import '../../../../core/services/hive/exceptions.dart';
import '../../../../core/services/hive/hive_content.dart';
import '../../../../core/services/hive/hive_service.dart';
import '../../../chat/data/dtos/chat_dto.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/message_repository.dart';
import '../dtos/message_dto.dart';

@LazySingleton(as: MessageRepository)
class MessageRepositoryImpl implements MessageRepository {
  final HiveService _hiveService;
  final AutoReplyAgentService _autoReplyAgentService;
  MessageRepositoryImpl(this._hiveService, this._autoReplyAgentService);

  static const String _messagesRecordKey = 'messages_record';

  @override
  Stream<List<Message>> watchMessages(String chatId) {
    try {
      return _hiveService
          .watchListMap<MessageDto>(
            _messagesRecordKey,
            fromJson: MessageDto.fromJson,
          )
          .map((messagesDto) {
            final messages =
                messagesDto
                    .map((dto) => dto.toDomain())
                    .where(
                      (message) => message.chatId == chatId && message.isValid,
                    )
                    .toList()
                  ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

            return messages;
          });
    } catch (e) {
      return Stream.value([]);
    }
  }

  @override
  Future<Result<Message>> sendMessage({required Message message}) async {
    try {
      final existingMessagesJson =
          _hiveService.readListMap<MessageDto>(
            _messagesRecordKey,
            fromJson: MessageDto.fromJson,
          ) ??
          [];

      final messageDto = message.toDto();
      final updatedMessagesJson = [
        ...existingMessagesJson.map((dto) => dto.toJson()),
        messageDto.toJson(),
      ];

      await _hiveService.save(
        HiveContent.listMap(
          key: _messagesRecordKey,
          value: updatedMessagesJson,
        ),
      );

      await _updateChatLastMessageTimestamp(
        chatId: message.chatId,
        timestamp: message.timestamp,
      );

      if (message.isSelf) {
        await _markMessagesAsRead(message.chatId);
        _triggerAutoReplyInBackground(message.chatId, message);
      }

      return Result.success(message);
    } on CacheReadException {
      return Result.failure(FailedToSendMessageFailure());
    } on CacheWriteException {
      return Result.failure(FailedToSendMessageFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  Future<void> _updateChatLastMessageTimestamp({
    required String chatId,
    required DateTime timestamp,
  }) async {
    try {
      const chatRecordsKey = 'chat_records';
      final chatsJson = _hiveService.readListMap<ChatDto>(
        chatRecordsKey,
        fromJson: ChatDto.fromJson,
      );

      if (chatsJson == null) return;

      final chatDto = chatsJson.firstWhereOrNull((dto) => dto.id == chatId);
      if (chatDto == null) return;

      final unreadCount = _calculateUnreadCount(chatId);

      final updatedChatDto = ChatDto(
        id: chatDto.id,
        user: chatDto.user,
        agent: chatDto.agent,
        lastMessageTimestamp: timestamp.toIso8601String(),
        unreadCount: unreadCount,
      );

      final updatedChatsJson = chatsJson.map((dto) {
        if (dto.id == chatId) {
          return updatedChatDto.toJson();
        }
        return dto.toJson();
      }).toList();

      await _hiveService.save(
        HiveContent.listMap(key: chatRecordsKey, value: updatedChatsJson),
      );
    } catch (_) {
      // Silently fail - chat update is not critical for message sending
    }
  }

  int _calculateUnreadCount(String chatId) {
    try {
      final messagesJson = _hiveService.readListMap<MessageDto>(
        _messagesRecordKey,
        fromJson: MessageDto.fromJson,
      );

      if (messagesJson == null) return 0;

      final messages = messagesJson
          .map((dto) => dto.toDomain())
          .where((message) => message.chatId == chatId && message.isValid)
          .toList();

      return messages
          .where((message) => message.status != MessageStatus.read)
          .length;
    } catch (_) {
      return 0;
    }
  }

  @override
  Future<void> markMessagesAsRead({required String chatId}) async {
    try {
      await _markMessagesAsRead(chatId);
    } catch (e) {
      // Silently fail - message update is not critical
    }
  }

  Future<void> _markMessagesAsRead(String chatId) async {
    try {
      final messagesJson = _hiveService.readListMap<MessageDto>(
        _messagesRecordKey,
        fromJson: MessageDto.fromJson,
      );

      if (messagesJson == null) {
        return;
      }

      final updatedMessagesJson = messagesJson.map((dto) {
        final message = dto.toDomain();
        if (message.chatId == chatId && message.status != MessageStatus.read) {
          final updatedMessage = message.copyWith(status: MessageStatus.read);
          return updatedMessage.toDto().toJson();
        }
        return dto.toJson();
      }).toList();

      await _hiveService.save(
        HiveContent.listMap(
          key: _messagesRecordKey,
          value: updatedMessagesJson,
        ),
      );

      await _updateChatUnreadCount(chatId: chatId, unreadCount: 0);
    } catch (_) {
      // Silently fail - message update is not critical
    }
  }

  Future<void> _updateChatUnreadCount({
    required String chatId,
    required int unreadCount,
  }) async {
    try {
      const chatRecordsKey = 'chat_records';
      final chatsJson = _hiveService.readListMap<ChatDto>(
        chatRecordsKey,
        fromJson: ChatDto.fromJson,
      );

      if (chatsJson == null) return;

      final chatDto = chatsJson.firstWhereOrNull((dto) => dto.id == chatId);
      if (chatDto == null) return;

      final updatedChatDto = ChatDto(
        id: chatDto.id,
        user: chatDto.user,
        agent: chatDto.agent,
        lastMessageTimestamp: chatDto.lastMessageTimestamp,
        unreadCount: unreadCount,
      );

      final updatedChatsJson = chatsJson.map((dto) {
        if (dto.id == chatId) {
          return updatedChatDto.toJson();
        }
        return dto.toJson();
      }).toList();

      await _hiveService.save(
        HiveContent.listMap(key: chatRecordsKey, value: updatedChatsJson),
      );
    } catch (_) {
      // Silently fail - chat update is not critical
    }
  }

  void _triggerAutoReplyInBackground(String chatId, Message userMessage) {
    unawaited(_sendAutoReply(chatId, userMessage));
  }

  Future<void> _sendAutoReply(String chatId, Message userMessage) async {
    try {
      if (!_autoReplyAgentService.isInitialized) {
        return;
      }

      final chatDto = _getChatById(chatId);
      if (chatDto == null || chatDto.agent?.id == null) {
        return;
      }

      final autoReply = await _autoReplyAgentService.getRandomAutoReply(
        userMessage: userMessage.content,
      );
      final agentId = chatDto.agent!.id!;

      final messageType = autoReply.type == AutoReplyType.text
          ? MessageType.text
          : MessageType.image;

      final agentMessage = Message(
        id: const Uuid().v4(),
        chatId: chatId,
        senderId: agentId,
        content: autoReply.content,
        type: messageType,
        timestamp: DateTime.now(),
        isSelf: false,
        status: MessageStatus.sent,
        media: autoReply.media,
      );

      if (!agentMessage.isValid) {
        return;
      }

      final existingMessagesJson =
          _hiveService.readListMap<MessageDto>(
            _messagesRecordKey,
            fromJson: MessageDto.fromJson,
          ) ??
          [];

      final messageDto = agentMessage.toDto();
      final updatedMessagesJson = [
        ...existingMessagesJson.map((dto) => dto.toJson()),
        messageDto.toJson(),
      ];

      await _hiveService.save(
        HiveContent.listMap(
          key: _messagesRecordKey,
          value: updatedMessagesJson,
        ),
      );

      await _updateChatLastMessageTimestamp(
        chatId: chatId,
        timestamp: agentMessage.timestamp,
      );
    } catch (_) {
      // Silently fail - auto-reply is not critical
    }
  }

  ChatDto? _getChatById(String chatId) {
    try {
      const chatRecordsKey = 'chat_records';
      final chatsJson = _hiveService.readListMap<ChatDto>(
        chatRecordsKey,
        fromJson: ChatDto.fromJson,
      );

      if (chatsJson == null) return null;

      return chatsJson.firstWhereOrNull((dto) => dto.id == chatId);
    } catch (_) {
      return null;
    }
  }
}
