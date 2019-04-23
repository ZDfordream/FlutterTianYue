import 'package:flutter/material.dart';
import 'package:tianyue/comic_home/comic_block_header_view.dart';
import 'package:tianyue/comic_home/comic_update_today_item_view.dart';
import 'package:tianyue/public.dart';

class ComicUpdateTodayView extends StatelessWidget {
  final List<UpdateToday> updateTodayList;

  ComicUpdateTodayView(this.updateTodayList);

  @override
  Widget build(BuildContext context) {
    if (updateTodayList == null || updateTodayList.length == 0) {
      return Container();
    }
    var leftImageHeight = Screen.width * 0.93;
    var children = updateTodayList
        .map((comicItem) => ComicUpdateTodayItemView(comicItem))
        .toList();
    return Container(
      color: TYColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ComicBlockHeaderView(Constant.updateToday),
          Row(
            children: <Widget>[
              Expanded(
                child: Image.asset(
                  "img/comic_update_today_left.png",
                  fit: BoxFit.cover,
                  height: leftImageHeight,
                ),
              ),
              Container(
                child: Wrap(
                    spacing: 15,
                    runSpacing: 0,
                    direction: Axis.vertical,
                    children: children),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
