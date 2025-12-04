import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget({super.key, required this.count, this.child});

  final int count;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Badge(
      label: Text(
        count > 99 ? '99+' : count.toString(),
        style: theme.textTheme.bodySmall?.copyWith(color: colorScheme.onError),
      ),
      backgroundColor: colorScheme.error,
      child: child,
    );
  }
}
