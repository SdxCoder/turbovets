import 'package:flutter/material.dart';
import 'package:turbovetschat/core/utils/date_formatter.dart';

class MessageTimestamp extends StatelessWidget {
  const MessageTimestamp({super.key, required this.timestamp});

  final DateTime timestamp;

  @override
  Widget build(BuildContext context) {
    return Text(
      DateFormatter.formatTime(timestamp),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}
