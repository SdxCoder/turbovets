import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turbovetschat/config/injection/injection.dart';
import 'package:turbovetschat/config/routes/app_router.dart';
import 'package:turbovetschat/features/agents/domain/entities/agent.dart';
import 'package:turbovetschat/features/agents/presentation/bloc/agent_cubit.dart';

import '../../../../core/errors/failure_message_mapper.dart';
import '../../../../core/themes/spacings.dart';
import '../../../../core/utils/asset_names.dart';
import '../../../agents/presentation/dialogs/start_chat_dialog.dart';
import '../bloc/chats_cubit.dart';
import '../bloc/chats_state.dart';
import '../widgets/chat_list_item.dart';
import '../widgets/empty_chats.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChatsCubit>()..loadChats(),
      child: const ChatsView(),
    );
  }
}

class ChatsView extends StatelessWidget {
  const ChatsView({super.key});

  Future<void> _handleStartChat(BuildContext context) async {
    context.router.openDialog<Agent>(
      child: StartChatDialog(
        agentCubit: context.read<AgentCubit>(),
        chatsCubit: context.read<ChatsCubit>(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats', style: Theme.of(context).textTheme.titleMedium),
        actions: [
          BlocSelector<ChatsCubit, ChatsState, bool>(
            selector: (state) {
              return state.chats.isEmpty;
            },
            builder: (context, chatsAreEmpty) {
              return chatsAreEmpty
                  ? const SizedBox.shrink()
                  : IconButton(
                      icon: SvgPicture.asset(AssetNames.iconGroup),
                      onPressed: () => _handleStartChat(context),
                    );
            },
          ),
        ],
      ),
      body: BlocConsumer<ChatsCubit, ChatsState>(
        listenWhen: (previous, current) => current.failure != null,
        listener: (context, state) {
          if (state.failure != null) {
            final message = FailureMessageMapper.mapFailureToMessage(
              state.failure!,
            );
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(message.message)));
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.chats.isEmpty) {
            return EmptyChats(onStartChat: () => _handleStartChat(context));
          }

          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
            itemCount: state.chats.length,
            separatorBuilder: (context, index) => Divider(
              height: 1,
              thickness: 1,
              color: Theme.of(context).colorScheme.outline,
            ),
            itemBuilder: (context, index) {
              final chat = state.chats[index];
              return ChatListItem(chat: chat);
            },
          );
        },
      ),
    );
  }
}
