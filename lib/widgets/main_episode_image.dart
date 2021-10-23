import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class MainEpisodeImage extends StatelessWidget {
  const MainEpisodeImage({
    required this.imageUrl,
    this.height,
    this.width,
    Key? key,
  }) : super(key: key);

  final String imageUrl;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      placeholder: (context, url) => Container(
        height: height,
        width: width ?? MediaQuery.of(context).size.width,
        color: CustomColors.middle,
        child: const Center(child: CircularProgressIndicator()),
      ),
      imageUrl: imageUrl,
      fit: BoxFit.cover,
    );
  }
}
