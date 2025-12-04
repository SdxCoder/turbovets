import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:turbovetschat/config/routes/app_router.dart';
import 'package:turbovetschat/features/agents/presentation/bloc/agent_cubit.dart';

import '../../../../core/themes/spacings.dart';
import '../../../../core/utils/asset_names.dart';
import '../../../agents/presentation/dialogs/start_chat_dialog.dart';

class EmptyChats extends StatelessWidget {
  const EmptyChats({super.key});

  void _handleStartChat(BuildContext context) {
    context.router.openDialog(
      child: StartChatDialog(agentCubit: context.read<AgentCubit>()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.lg),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetNames.iconChatEmpty,
              width: 120,
              height: 120,
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: Spacing.xl),
            Text(
              "Let's start chatting!",
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.md),
            TextButton(
              onPressed: () => _handleStartChat(context),
              child: const Text('Start a chat'),
            ),
          ],
        ),
      ),
    );
  }
}
