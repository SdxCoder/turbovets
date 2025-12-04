import 'package:flutter/material.dart';

import '../../../../core/themes/spacings.dart';
import '../../../../core/widgets/badge_widget.dart';
import '../../../../core/widgets/list_item_content_widget.dart';
import '../../../../core/widgets/network_image_widget.dart';
import '../../../../core/widgets/timestamp_widget.dart';
import '../../../../mock_data/chat.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({super.key, required this.chat, required this.onTap});

  final MockChat chat;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Spacing.md,
          vertical: Spacing.sm,
        ),
        child: Row(
          spacing: Spacing.md,
          children: [
            NetworkImageWidget(imageUrl: chat.imageUrl),
            ListItemContentWidget(title: chat.name, subtitle: chat.lastMessage),
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
                    Icon(
                      chat.isRead ? Icons.done_all : Icons.done,
                      size: 16,
                      color: chat.isRead
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary,
                    ),
                    const SizedBox(width: Spacing.xs),
                    TimestampWidget(isoDateString: chat.timestamp),
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
