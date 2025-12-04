import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/errors/result.dart';
import '../../../../core/services/hive/exceptions.dart';
import '../../../../core/services/hive/hive_content.dart';
import '../../../../core/services/hive/hive_service.dart';
import '../../../agents/data/dtos/agent_dto.dart';
import '../../../auth/data/dtos/user_dto.dart';
import '../../domain/entities/chat.dart';
import '../../domain/repositories/chat_repository.dart';
import '../dtos/chat_dto.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final HiveService _hiveService;
  ChatRepositoryImpl(this._hiveService);

  static const String _agentsRecordKey = 'agents_record';
  static const String _chatRecordsKey = 'chat_records';
  static const String _currentUserKey = 'current_user';

  @override
  Future<Result<Chat>> createChat({
    required String userId,
    required String agentId,
  }) async {
    try {
      final userDto = _hiveService.readMap<UserDto>(
        _currentUserKey,
        fromJson: UserDto.fromJson,
      );

      if (userDto == null) {
        return Result.failure(CacheReadFailure());
      }

      final agentsJson = _hiveService.readListMap<AgentDto>(
        _agentsRecordKey,
        fromJson: AgentDto.fromJson,
      );

      if (agentsJson == null || agentsJson.isEmpty) {
        return Result.failure(const AgentsNotInitializedFailure());
      }

      final agentDto = agentsJson.firstWhereOrNull(
        (agent) => agent.id == agentId,
      );

      if (agentDto == null) {
        return Result.failure(const AgentNotFoundFailure());
      }

      final existingChatsJson =
          _hiveService.readListMap<ChatDto>(
            _chatRecordsKey,
            fromJson: ChatDto.fromJson,
          ) ??
          [];

      final chatExists = existingChatsJson.any(
        (chat) => chat.user?.id == userDto.id && chat.agent?.id == agentId,
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
  Future<Result<List<Chat>>> getChats() async {
    try {
      final chatsJson = _hiveService.readListMap<ChatDto>(
        _chatRecordsKey,
        fromJson: ChatDto.fromJson,
      );

      if (chatsJson == null) {
        return Result.success([]);
      }

      final chats = chatsJson.map((dto) => dto.toDomain()).toList();

      return Result.success(chats);
    } on CacheReadException {
      return Result.failure(CacheReadFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
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

      final chatDto = chatsJson.firstWhere(
        (chat) => chat.id == chatId,
        orElse: () => throw Exception('Chat not found'),
      );

      final chat = chatDto.toDomain();

      return Result.success(chat);
    } on CacheReadException {
      return Result.failure(CacheReadFailure());
    } catch (e) {
      return Result.failure(UnknownFailure());
    }
  }
}
