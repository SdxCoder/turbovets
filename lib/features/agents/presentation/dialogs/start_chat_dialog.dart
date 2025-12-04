import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/errors/failure_message_mapper.dart';
import '../../../../core/themes/spacings.dart';
import '../../../../core/widgets/base_action_dialog_widget.dart';
import '../bloc/agent_cubit.dart';
import '../bloc/agent_state.dart';
import '../widgets/agent_list_item.dart';

class StartChatDialog extends StatelessWidget {
  final AgentCubit agentCubit;
  const StartChatDialog({super.key, required this.agentCubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: agentCubit, child: StartChatDialogView());
  }
}

class StartChatDialogView extends StatelessWidget {
  const StartChatDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AgentCubit, AgentState>(
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
          return const BaseActionDialogWidget(
            padding: EdgeInsets.all(Spacing.lg),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.agents.isEmpty) {
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

        return BaseActionDialogWidget(
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
                itemCount: state.agents.length,
                separatorBuilder: (context, index) => Divider(
                  height: 1,
                  thickness: 1,
                  color: Theme.of(context).colorScheme.outline,
                ),
                itemBuilder: (context, index) {
                  final agent = state.agents[index];
                  return AgentListItem(
                    agent: agent,
                    onTap: () {
                      // TODO: Navigate to chat screen
                    },
                  );
                },
              ),
              const SizedBox(height: Spacing.lg),
            ],
          ),
        );
      },
    );
  }
}
