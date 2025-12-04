import 'package:flutter/material.dart';

import '../../../../core/themes/spacings.dart';
import '../../../../mock_data/chats_data.dart';
import 'chat_list_item.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: Spacing.sm),
      itemCount: ChatsData.chats.length,
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 1,
        color: Theme.of(context).colorScheme.outline,
      ),
      itemBuilder: (context, index) {
        final chat = ChatsData.chats[index];
        return ChatListItem(
          chat: chat,
          onTap: () {
            // TODO: Navigate to chat detail
          },
        );
      },
    );
  }
}
