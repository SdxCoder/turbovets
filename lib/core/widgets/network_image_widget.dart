import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  const NetworkImageWidget({
    super.key,
    required this.imageUrl,
    this.width = 48,
    this.height = 48,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorPlaceholder,
  });

  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget Function(BuildContext, String)? placeholder;
  final Widget? errorPlaceholder;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder:
          placeholder ??
          (context, url) => Container(
            width: width,
            height: height,
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
      errorWidget: (context, url, error) => Container(
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
