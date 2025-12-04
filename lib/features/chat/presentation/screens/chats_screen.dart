import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:turbovetschat/config/routes/app_router.dart';
import 'package:turbovetschat/features/agents/presentation/bloc/agent_cubit.dart';

import '../../../../core/utils/asset_names.dart';
import '../../../agents/presentation/dialogs/start_chat_dialog.dart';
import '../widgets/chats_list.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats', style: Theme.of(context).textTheme.titleMedium),
        actions: [
          IconButton(
            icon: SvgPicture.asset(AssetNames.iconGroup),
            onPressed: () {
              context.router.openDialog(
                child: StartChatDialog(agentCubit: context.read<AgentCubit>()),
              );
            },
          ),
        ],
      ),
      body: const ChatsList(),
    );
  }
}
