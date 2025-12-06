import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../config/routes/app_router.dart';
import '../../../../core/themes/spacings.dart';
import '../../../../core/widgets/badge_widget.dart';
import '../../../../core/widgets/list_item_content_widget.dart';
import '../../../../core/widgets/network_image_widget.dart';
import '../../../../core/widgets/timestamp_widget.dart';
import '../../domain/entities/chat.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({super.key, required this.chat});

  final Chat chat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.router.push(MessagesRoute(chatId: chat.id));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        child: Row(
          spacing: Spacing.md,
          children: [
            ClipOval(child: NetworkImageWidget(imageUrl: chat.agent.imageUrl)),
            Expanded(
              child: ListItemContentWidget(
                title: chat.agent.name,
                subtitle: chat.lastMessageTimestamp.isValid
                    ? 'Tap to view messages'
                    : 'Start a new chat',
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility.maintain(
                  visible: chat.unreadCount > 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: Spacing.xs),
                    child: BadgeWidget(count: chat.unreadCount),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (chat.lastMessageTimestamp.isValid) ...[
                      Icon(
                        Icons.done_all,
                        size: 16,
                        color: chat.isRead
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.secondary,
                      ),
                    ],
                    if (chat.lastMessageTimestamp.isValid) ...[
                      const SizedBox(width: Spacing.xs),
                      TimestampWidget(
                        isoDateString: chat.lastMessageTimestamp.value,
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
