import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/hive/exceptions.dart';
import '../../../../core/services/hive/hive_content.dart';
import '../../../../core/services/hive/hive_service.dart';
import '../../../../core/utils/fake_network_delay.dart';
import '../../../agents/data/dtos/agent_dto.dart';
import '../../../agents/domain/entities/agent.dart';
import '../../../auth/data/dtos/user_dto.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/chat.dart';
import '../../domain/repositories/chat_repository.dart';
import '../dtos/chat_dto.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final HiveService _hiveService;
  ChatRepositoryImpl(this._hiveService);

  static const String _chatRecordsKey = 'chat_records';

  @override
  Future<Result<Chat>> createChat({
    required Agent agent,
    required User user,
  }) async {
    try {
      await FakeNetworkDelay.delay();
      final agentDto = agent.toDto();
      final userDto = user.toDto();

      final existingChatsJson =
          _hiveService.readListMap<ChatDto>(
            _chatRecordsKey,
            fromJson: ChatDto.fromJson,
          ) ??
          [];

      final chatExists = existingChatsJson.any(
        (chat) => chat.user?.id == userDto.id && chat.agent?.id == agentDto.id,
      );

      if (chatExists) {
        return Result.failure(const ChatAlreadyExistsFailure());
      }

      final chatId = const Uuid().v4();
      final chatDto = ChatDto(
        id: chatId,
        user: userDto,
        agent: agentDto,
        isRead: false,
        lastMessageTimestamp: null,
        unreadCount: 0,
      );

      final updatedChatsJson = [
        ...existingChatsJson.map((dto) => dto.toJson()),
        chatDto.toJson(),
      ];

      await _hiveService.save(
        HiveContent.listMap(key: _chatRecordsKey, value: updatedChatsJson),
      );

      final chat = chatDto.toDomain();
      return Result.success(chat);
    } on CacheReadException {
      return Result.failure(CacheReadFailure());
    } on CacheWriteException {
      return Result.failure(CacheWriteFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  Stream<List<Chat>> watchChats() {
    try {
      return _hiveService
          .watchListMap<ChatDto>(_chatRecordsKey, fromJson: ChatDto.fromJson)
          .map((chatsDto) {
            final chats = chatsDto
                .map((dto) => dto.toDomain())
                .where((chat) => chat.isValid)
                .toList();

            chats.sort((a, b) {
              if (!a.lastMessageTimestamp.isValid &&
                  !b.lastMessageTimestamp.isValid) {
                return 0;
              }
              if (!a.lastMessageTimestamp.isValid) return 1;
              if (!b.lastMessageTimestamp.isValid) return -1;

              final aDate = DateTime.tryParse(a.lastMessageTimestamp.value);
              final bDate = DateTime.tryParse(b.lastMessageTimestamp.value);

              if (aDate == null && bDate == null) return 0;
              if (aDate == null) return 1;
              if (bDate == null) return -1;

              return bDate.compareTo(aDate);
            });

            return chats;
          });
    } catch (e) {
      return Stream.value([]);
    }
  }

  @override
  Future<Result<Chat>> getChatById(String chatId) async {
    try {
      final chatsJson = _hiveService.readListMap<ChatDto>(
        _chatRecordsKey,
        fromJson: ChatDto.fromJson,
      );

      if (chatsJson == null) {
        return Result.failure(const ChatNotFoundFailure());
      }

      final chatDto = chatsJson.firstWhereOrNull((chat) => chat.id == chatId);

      final chat = chatDto?.toDomain();

      if (chat == null || !chat.isValid) {
        return Result.failure(const ChatNotFoundFailure());
      }

      return Result.success(chat);
    } on CacheReadException {
      return Result.failure(CacheReadFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }

  @override
  Future<Result<Chat>> getChatByUserAndAgentId(
    String userId,
    String agentId,
  ) async {
    try {
      final chatsJson = _hiveService.readListMap<ChatDto>(
        _chatRecordsKey,
        fromJson: ChatDto.fromJson,
      );

      if (chatsJson == null) {
        return Result.failure(const ChatNotFoundFailure());
      }

      final chatDto = chatsJson.firstWhereOrNull(
        (chat) => chat.agent?.id == agentId && chat.user?.id == userId,
      );

      final chat = chatDto?.toDomain();

      if (chat == null || !chat.isValid) {
        return Result.failure(const ChatNotFoundFailure());
      }

      return Result.success(chat);
    } on CacheReadException {
      return Result.failure(CacheReadFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }
}
