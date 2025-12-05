import 'package:flutter/material.dart';

import '../../../../core/themes/spacings.dart';
import '../../../../core/widgets/list_item_content_widget.dart';
import '../../../../core/widgets/network_image_widget.dart';
import '../../domain/entities/agent.dart';

class AgentListItem extends StatelessWidget {
  const AgentListItem({super.key, required this.agent, required this.onTap});

  final Agent agent;
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
          children: [
            NetworkImageWidget(imageUrl: agent.imageUrl),
            const SizedBox(width: Spacing.md),
            Expanded(
              child: ListItemContentWidget(
                title: agent.name,
                subtitle: agent.description,
              ),
            ),
            Icon(Icons.chevron_right),
          ],
        ),
      ),
    );
  }
}
