import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:turbovetschat/core/themes/spacings.dart';

import '../../../../core/widgets/base_action_dialog_widget.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;
  const LogoutDialog({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return BaseActionDialogWidget(
      onAction: onLogout,
      onCancel: () => context.router.pop(),
      actionText: 'Logout',
      cancelText: 'Cancel',
      child: Column(
        children: [
          Text('Logout', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: Spacing.md),
          Text(
            'Are you sure you want to logout?',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
