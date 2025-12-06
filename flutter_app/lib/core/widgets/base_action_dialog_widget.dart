import 'package:flutter/material.dart';

import '../themes/spacings.dart';

class BaseActionDialogWidget extends StatelessWidget {
  const BaseActionDialogWidget({
    super.key,
    required this.child,
    this.cancelText,
    this.actionText,
    this.onCancel,
    this.onAction,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final String? cancelText;
  final String? actionText;
  final VoidCallback? onCancel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final renderButtons = onAction != null || onCancel != null;
    return Dialog(
      child: Padding(
        padding: padding ?? const EdgeInsets.all(Spacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Spacing.xl,
          children: [
            child,
            if (renderButtons)
              Row(
                spacing: Spacing.md,
                children: [
                  if (onCancel != null)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: onCancel,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Theme.of(context).colorScheme.error,
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        child: Text(cancelText ?? 'Cancel'),
                      ),
                    ),
                  if (onAction != null) ...[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: onAction,
                        child: Text(actionText ?? 'Ok'),
                      ),
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }
}
