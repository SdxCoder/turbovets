import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:turbovetschat/config/routes/app_router.dart';
import 'package:turbovetschat/features/agents/domain/entities/agent.dart';
import 'package:turbovetschat/features/auth/domain/usecases/get_current_user.dart';

import '../../../../core/errors/result.dart';
import '../../domain/entities/chat.dart';
import '../../domain/usecases/create_chat.dart';
import '../../domain/usecases/watch_chats.dart';
import 'chats_state.dart';

@injectable
class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this._createChat, this._watchChats, this._getCurrentUser)
    : super(ChatsState.initial()) {
    _startWatchingChats();
  }

  final CreateChat _createChat;
  final WatchChats _watchChats;
  final GetCurrentUser _getCurrentUser;
  StreamSubscription<List<Chat>>? _chatsSubscription;

  Future<void> _startWatchingChats() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getCurrentUser();
    emit(state.copyWith(isLoading: false));
    switch (result) {
      case Success(:final data):
        final currentUserId = data.user.id;
        _chatsSubscription?.cancel();
        _chatsSubscription = _watchChats(currentUserId).listen((chats) {
          emit(state.copyWith(chats: chats));
        });
      case Error():
        return;
    }
  }

  Future<void> createChat({
    required Agent agent,
    required StackRouter router,
  }) async {
    emit(state.copyWith(isCreatingChat: true));
    final result = await _createChat(agent: agent);
    emit(state.copyWith(isCreatingChat: false));

    switch (result) {
      case Success(:final data):
        router.pop();
        router.push(MessagesRoute(chatId: data.id));
      case Error(:final failure):
        emit(state.copyWith(failure: failure));
    }
  }

  @override
  Future<void> close() {
    _chatsSubscription?.cancel();
    return super.close();
  }
}
