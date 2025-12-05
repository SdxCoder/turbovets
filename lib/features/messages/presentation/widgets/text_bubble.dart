import 'package:flutter/material.dart';
import 'package:turbovetschat/core/themes/radiuses.dart';

import '../../../../core/themes/spacings.dart';

class TextBubble extends StatelessWidget {
  const TextBubble({super.key, required this.text, required this.isRight});

  final String text;
  final bool isRight;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final radius = Radius.circular(Radii.md);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.sm,
      ),
      decoration: BoxDecoration(
        color: isRight
            ? colorScheme.primary
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.only(
          topLeft: radius,
          topRight: radius,
          bottomLeft: isRight ? radius : Radius.zero,
          bottomRight: isRight ? Radius.zero : Radius.circular(12),
        ),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: isRight ? colorScheme.onPrimary : colorScheme.onSurface,
        ),
      ),
    );
  }
}
