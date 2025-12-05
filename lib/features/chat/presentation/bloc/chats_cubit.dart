import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:turbovetschat/config/routes/app_router.dart';
import 'package:turbovetschat/features/agents/domain/entities/agent.dart';

import '../../../../core/errors/result.dart';
import '../../domain/usecases/create_chat.dart';
import '../../domain/usecases/get_chats.dart';
import 'chats_state.dart';

@injectable
class ChatsCubit extends Cubit<ChatsState> {
  ChatsCubit(this._createChat, this._getChats) : super(ChatsState.initial());

  final CreateChat _createChat;
  final GetChats _getChats;

  Future<void> loadChats() async {
    emit(state.copyWith(isLoading: true, failure: null));
    final result = await _getChats();
    emit(state.copyWith(isLoading: false));

    switch (result) {
      case Success(:final data):
        emit(state.copyWith(chats: data, isLoading: false, failure: null));
      case Error(:final failure):
        emit(state.copyWith(failure: failure));
    }
  }

  Future<void> createChat({
    required Agent agent,
    required StackRouter router,
  }) async {
    emit(state.copyWith(isCreatingChat: true, failure: null));
    final result = await _createChat(agent: agent);
    emit(state.copyWith(isCreatingChat: false));

    switch (result) {
      case Success(:final data):
        router.pop();
        await loadChats();
        router.push(MessagesRoute(chatId: data.id));
      case Error(:final failure):
        emit(state.copyWith(failure: failure));
    }
  }
}
