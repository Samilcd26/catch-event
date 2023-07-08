import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'loading_animation.dart';

class CachedImageProvider extends StatelessWidget {
  CachedImageProvider({super.key, required this.imageUrl});
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: imageProvider, fit: BoxFit.cover, colorFilter: const ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
        ),
      ),
      placeholder: (context, url) => const ImageLoadAnimation(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}

class CachedNetImage extends StatelessWidget {
  CachedNetImage({super.key, required this.imageUrl});
  String imageUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => const ImageLoadAnimation(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
