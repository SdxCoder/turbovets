import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turbovetschat/features/chat/presentation/bloc/chats_cubit.dart';

import '../../../../core/errors/failure_message_mapper.dart';
import '../../../../core/themes/spacings.dart';
import '../../../../core/widgets/base_action_dialog_widget.dart';
import '../bloc/agent_cubit.dart';
import '../bloc/agent_state.dart';
import '../widgets/agent_list_item.dart';

class StartChatDialog extends StatelessWidget {
  final AgentCubit agentCubit;
  final ChatsCubit chatsCubit;
  const StartChatDialog({
    super.key,
    required this.agentCubit,
    required this.chatsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: agentCubit),
        BlocProvider.value(value: chatsCubit),
      ],
      child: StartChatDialogView(),
    );
  }
}

class StartChatDialogView extends StatelessWidget {
  const StartChatDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    final isCreatingChat = context.select(
      (ChatsCubit chatsCubit) => chatsCubit.state.isCreatingChat,
    );
    final agents = context.select(
      (AgentCubit agentCubit) => agentCubit.state.agents,
    );
    final isLoading = context.select(
      (AgentCubit agentCubit) => agentCubit.state.isLoading,
    );

    if (isLoading || isCreatingChat) {
      return const BaseActionDialogWidget(
        padding: EdgeInsets.all(Spacing.lg),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (agents.isEmpty) {
      return BaseActionDialogWidget(
        padding: const EdgeInsets.all(Spacing.lg),
        actionText: 'Reload',
        onAction: () {
          context.read<AgentCubit>().loadAgents();
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No agents available',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: Spacing.md),
            Text(
              'Please try again later',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    return BlocListener<AgentCubit, AgentState>(
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
      child: BaseActionDialogWidget(
        padding: EdgeInsets.zero,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(Spacing.lg),
              child: Text(
                'Select an agent',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: agents.length,
              separatorBuilder: (context, index) => Divider(
                height: 1,
                thickness: 1,
                color: Theme.of(context).colorScheme.outline,
              ),
              itemBuilder: (context, index) {
                final agent = agents[index];
                return AgentListItem(
                  agent: agent,
                  onTap: () {
                    context.read<ChatsCubit>().createChat(
                      agent: agent,
                      router: context.router,
                    );
                  },
                );
              },
            ),
            const SizedBox(height: Spacing.lg),
          ],
        ),
      ),
    );
  }
}
