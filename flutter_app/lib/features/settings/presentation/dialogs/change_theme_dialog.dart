import 'package:flutter/material.dart';
import 'package:turbovetschat/core/themes/spacings.dart';

import '../../../../core/widgets/base_action_dialog_widget.dart';

class ChangeThemeDialog extends StatelessWidget {
  final ThemeMode? selectedTheme;
  final Function(ThemeMode? value) onChange;
  const ChangeThemeDialog({
    super.key,
    required this.onChange,
    this.selectedTheme,
  });

  @override
  Widget build(BuildContext context) {
    return BaseActionDialogWidget(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Change theme', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: Spacing.md),
          ...ThemeMode.values
              .where((themeMode) => themeMode != ThemeMode.system)
              .map(
                (themeMode) => RadioGroup(
                  groupValue: selectedTheme,
                  onChanged: (value) => onChange(value),
                  child: RadioListTile(
                    contentPadding: EdgeInsets.zero,
                    value: themeMode,
                    title: Text(_getThemeModeLabel(themeMode)),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  String _getThemeModeLabel(ThemeMode themeMode) {
    return switch (themeMode) {
      ThemeMode.light => 'Light',
      ThemeMode.dark => 'Dark',
      _ => '',
    };
  }
}
