import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class ComicBlockItemView extends StatelessWidget {
  final ComicBlock comicItem;
  final Color bgColor;

  ComicBlockItemView(this.comicItem, this.bgColor);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 15 * 2) / 3;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushComicDetail(context, "");
      },
      child: Container(
        color: bgColor,
        width: width,
        child: Column(
          children: <Widget>[
            NovelCoverImage(comicItem.cover,
                width: width, height: width / 0.75),
            Text(
              comicItem.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none),
              maxLines: 1,
            ),
            Text(
              comicItem.description,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 12,
                  color: TYColor.gray,
                  decoration: TextDecoration.none),
              maxLines: 1,
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
