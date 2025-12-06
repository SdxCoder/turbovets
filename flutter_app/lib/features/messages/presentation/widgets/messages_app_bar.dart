import 'package:flutter/material.dart';

import '../../../../core/themes/spacings.dart';
import '../../../../core/widgets/network_image_widget.dart';

class MessagesAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MessagesAppBar({
    super.key,
    required this.agentName,
    required this.agentImageUrl,
    this.statusText,
  });

  final String agentName;
  final String agentImageUrl;
  final String? statusText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Column(
        children: [
          Text(agentName, style: Theme.of(context).textTheme.titleMedium),
          if (statusText != null)
            Text(
              statusText!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
        ],
      ),
      actions: [
        ClipOval(
          child: NetworkImageWidget(
            imageUrl: agentImageUrl,
            width: 40,
            height: 40,
          ),
        ),
        const SizedBox(width: Spacing.md),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
