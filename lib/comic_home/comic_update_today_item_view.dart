import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class ComicUpdateTodayItemView extends StatelessWidget {
  final UpdateToday comicItem;

  ComicUpdateTodayItemView(this.comicItem);

  @override
  Widget build(BuildContext context) {
    var itemWidth = Screen.width * 0.7;
    var imgWidth = Screen.width * 0.21;
    return GestureDetector(
      onTap: () {
        AppNavigator.pushComicDetail(context, "");
      },
      child: Container(
        color: TYColor.white,
        width: itemWidth,
        child: Row(
          children: <Widget>[
            NovelCoverImage(comicItem.cover,
                width: imgWidth, height: imgWidth * 1.32),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  comicItem.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
                Text(
                  comicItem.author,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, color: Color(0xff969696)),
                  maxLines: 1,
                ),
                Text(
                  comicItem.newUpdate,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 15, color: Color(0xff969696)),
                  maxLines: 1,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
