import 'package:flutter/material.dart';

import '../../../../core/themes/spacings.dart';
import '../../../../core/widgets/network_image_widget.dart';
import 'image_bubble.dart';
import 'text_bubble.dart';
import 'message_timestamp.dart';

class LeftMessage extends StatelessWidget {
  const LeftMessage({
    super.key,
    this.text,
    required this.avatarUrl,
    required this.timestamp,
    this.images,
  }) : assert(
         text != null || images != null,
         'Either text or images must be provided',
       );

  final String? text;
  final String avatarUrl;
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ClipOval(
            child: NetworkImageWidget(
              imageUrl: avatarUrl,
              width: 32,
              height: 32,
            ),
          ),
          const SizedBox(width: Spacing.sm),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (text != null) TextBubble(text: text!, isRight: false),
                if (images != null && images!.isNotEmpty)
                  ImageBubble(images: images!, isRight: false),
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
