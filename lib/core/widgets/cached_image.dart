import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../utils/image_utils.dart';

class CachedImage extends StatelessWidget {
  const CachedImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit = BoxFit.cover,
    this.borderRadius = 16,
  });

  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxFit fit;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    // On Flutter Web, route images through the local proxy to avoid CORS.
    final resolvedUrl = getProxiedImageUrl((imageUrl ?? '').trim());
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: resolvedUrl.isEmpty
          ? _placeholder()
          : CachedNetworkImage(
              imageUrl: resolvedUrl,
              height: height,
              width: width,
              fit: fit,
              placeholder: (context, url) => _placeholder(),
              errorWidget: (context, url, error) => _placeholder(),
            ),
    );
  }

  Widget _placeholder() {
    return Container(
      height: height,
      width: width,
      color: Colors.grey.shade200,
      child: const Icon(Icons.image_outlined),
    );
  }
}
