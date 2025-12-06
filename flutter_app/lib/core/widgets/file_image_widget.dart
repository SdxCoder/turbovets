import 'dart:io';

import 'package:flutter/material.dart';

class FileImageWidget extends StatelessWidget {
  const FileImageWidget({
    super.key,
    required this.filePath,
    this.width = 48,
    this.height = 48,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorPlaceholder,
  });

  final String filePath;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget Function(BuildContext)? placeholder;
  final Widget? errorPlaceholder;

  @override
  Widget build(BuildContext context) {
    final file = File(filePath);

    // if (!file.existsSync()) {
    //   return Container(
    //     width: width,
    //     height: height,
    //     color: Theme.of(context).colorScheme.surfaceContainerHighest,
    //     child:
    //         errorPlaceholder ??
    //         Icon(
    //           Icons.image,
    //           color: Theme.of(context).colorScheme.inverseSurface,
    //         ),
    //   );
    // }

    return Image.file(
      file,
      width: width,
      height: height,
      fit: fit,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded || frame != null) {
          return child;
        }
        return placeholder?.call(context) ??
            Container(
              width: width,
              height: height,
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
              child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
      },
      errorBuilder: (context, error, stackTrace) => Container(
        width: width,
        height: height,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        child:
            errorPlaceholder ??
            Icon(
              Icons.image,
              color: Theme.of(context).colorScheme.inverseSurface,
            ),
      ),
    );
  }
}
