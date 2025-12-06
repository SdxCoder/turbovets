import 'package:flutter/material.dart';

import '../../../../core/themes/radiuses.dart';
import '../../../../core/themes/spacings.dart';
import '../../../../core/widgets/file_image_widget.dart';
import '../../../../core/widgets/network_image_widget.dart';

class ImageBubble extends StatelessWidget {
  const ImageBubble({
    super.key,
    required this.images,
    required this.isRight,
    this.useFileImage = false,
  });

  final List<String> images;
  final bool isRight;
  final bool useFileImage;

  static const double _width = 200;
  static const double _height = 200;

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(Radii.md);

    final borderRadius = BorderRadius.only(
      topLeft: radius,
      topRight: radius,
      bottomLeft: isRight ? radius : Radius.zero,
      bottomRight: isRight ? Radius.zero : radius,
    );

    if (images.length == 1) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: SizedBox(
          width: _width,
          height: _height,
          child: useFileImage
              ? FileImageWidget(
                  filePath: images.first,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                )
              : NetworkImageWidget(
                  imageUrl: images.first,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
        ),
      );
    }

    if (images.length == 2) {
      return ClipRRect(
        borderRadius: borderRadius,
        child: SizedBox(
          width: _width,
          height: _height,
          child: Row(
            children: [
              Expanded(
                child: useFileImage
                    ? FileImageWidget(
                        filePath: images.first,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : NetworkImageWidget(
                        imageUrl: images.first,
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
              ),
              const SizedBox(width: 2),
              Expanded(
                child: useFileImage
                    ? FileImageWidget(
                        filePath: images[1],
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      )
                    : NetworkImageWidget(
                        imageUrl: images[1],
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
              ),
            ],
          ),
        ),
      );
    }

    final numberOfImages = images.length - 3;

    return ClipRRect(
      borderRadius: borderRadius,
      child: SizedBox(
        width: _width,
        height: _height,
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: useFileImage
                      ? FileImageWidget(
                          filePath: images.first,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : NetworkImageWidget(
                          imageUrl: images.first,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        ),
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: useFileImage
                            ? FileImageWidget(
                                filePath: images[1],
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : NetworkImageWidget(
                                imageUrl: images[1],
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ),
                      const SizedBox(height: 2),
                      Expanded(
                        child: useFileImage
                            ? FileImageWidget(
                                filePath: images[2],
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              )
                            : NetworkImageWidget(
                                imageUrl: images[2],
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (numberOfImages > 0)
              Positioned(
                bottom: Spacing.sm,
                right: Spacing.sm,
                child: Text('+$numberOfImages'),
              ),
          ],
        ),
      ),
    );
  }
}
