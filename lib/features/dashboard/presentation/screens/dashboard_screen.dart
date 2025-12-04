import 'package:flutter/material.dart';

import '../../../../core/themes/spacings.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.lg),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.dashboard_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(height: Spacing.xl),
                Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: Spacing.sm),
                Text(
                  'Dashboard content will appear here',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
