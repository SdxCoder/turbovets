import 'package:flutter/material.dart';

import '../../../../core/themes/spacings.dart';
import 'image_bubble.dart';
import 'text_bubble.dart';
import 'message_timestamp.dart';

class RightMessage extends StatelessWidget {
  const RightMessage({
    super.key,
    this.text,
    required this.timestamp,
    this.images,
  }) : assert(
         text != null || images != null,
         'Either text or images must be provided',
       );

  final String? text;
  final DateTime timestamp;
  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.md,
        vertical: Spacing.xs,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (text != null) TextBubble(text: text!, isRight: true),
                if (images != null && images!.isNotEmpty)
                  ImageBubble(
                    images: images!,
                    isRight: true,
                    useFileImage: true,
                  ),
                const SizedBox(height: Spacing.xxs),
                MessageTimestamp(timestamp: timestamp),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
