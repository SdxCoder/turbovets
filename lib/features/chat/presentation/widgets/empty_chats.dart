import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/themes/spacings.dart';
import '../../../../core/utils/asset_names.dart';

class EmptyChats extends StatelessWidget {
  final VoidCallback onStartChat;
  const EmptyChats({super.key, required this.onStartChat});

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
              onPressed: onStartChat,
              child: const Text('Start a chat'),
            ),
          ],
        ),
      ),
    );
  }
}
