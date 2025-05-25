import 'dart:typed_data';
import 'package:flutter/material.dart';

class ImageFromBytes extends StatelessWidget {
  final Uint8List? bytes;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadius borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const ImageFromBytes({
    super.key,
    required this.bytes,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.placeholder,
    this.errorWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (bytes == null || bytes!.isEmpty) {
      return errorWidget ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: borderRadius,
            ),
            child: const Icon(Icons.image_not_supported, size: 40),
          );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        image: DecorationImage(
          image: MemoryImage(bytes!),
          fit: fit,
        ),
      ),
    );
  }
}
