import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/ty_color.dart';

class NovelCoverImage extends StatelessWidget {
  final String imgUrl;
  final double width;
  final double height;
  final BoxFit fit;

  NovelCoverImage(this.imgUrl, {this.width, this.height, this.fit});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        fit: fit == null ? BoxFit.cover : fit,
        width: width,
        height: height,
      ),
      decoration: BoxDecoration(border: Border.all(color: TYColor.paper)),
    );
  }
}
