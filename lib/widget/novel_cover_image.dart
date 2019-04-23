import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/ty_color.dart';

class NovelCoverImage extends StatelessWidget {
  final String imgUrl;
  final double width;
  final double height;

  NovelCoverImage(this.imgUrl, {this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CachedNetworkImage(
        imageUrl: imgUrl,
        fit: BoxFit.cover,
        width: width,
        height: height,
        placeholder: Image.asset('img/bookshelf_bg.png'),
      ),
      decoration: BoxDecoration(border: Border.all(color: TYColor.paper)),
    );
  }
}
