import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class ComicBlockItemView extends StatelessWidget {
  final ComicBlock comicItem;

  ComicBlockItemView(this.comicItem);

  @override
  Widget build(BuildContext context) {
    var width = (Screen.width - 15 * 2 - 15 * 2) / 3;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushComicDetail(context, "");
      },
      child: Container(
        color: TYColor.white,
        width: width,
        child: Column(
          children: <Widget>[
            NovelCoverImage(comicItem.cover,
                width: width, height: width / 0.75),
            Text(
              comicItem.title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            Text(
              comicItem.description,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 12, color: TYColor.gray),
              maxLines: 1,
            ),
            SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
