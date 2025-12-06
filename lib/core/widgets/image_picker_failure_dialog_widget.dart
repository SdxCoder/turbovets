import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../themes/spacings.dart';
import 'base_action_dialog_widget.dart';

class ImagePickerFailureDialog extends StatelessWidget {
  final String title;
  final String message;
  const ImagePickerFailureDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return BaseActionDialogWidget(
      onAction: () => context.router.pop(),
      actionText: 'Ok',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: Spacing.md),
          Text(message, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
