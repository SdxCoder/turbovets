import 'package:flutter/material.dart';

import '../utils/date_formatter.dart';

class TimestampWidget extends StatelessWidget {
  const TimestampWidget({super.key, required this.isoDateString});

  final String isoDateString;

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormatter.formatTimestamp(isoDateString);

    if (formattedDate.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      formattedDate,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
