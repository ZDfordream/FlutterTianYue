import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class ComicBlockHeaderView extends StatelessWidget {
  final String titleName;

  ComicBlockHeaderView(this.titleName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildHeader(),
    );
  }

  Widget buildHeader() {
    Widget widget;
    var width = Screen.width;
    switch (titleName) {
      case Constant.comicBlock:
        widget = Image.asset(
          "img/comic_block_header.png",
          width: width,
        );
        break;
      case Constant.recommendEveryDay:
        widget = Image.asset(
          "img/comic_recommend_everyday_header.png",
          width: width,
        );
        break;
      case Constant.updateToday:
        widget = Image.asset(
          "img/comic_update_today_header.png",
          width: width,
        );
        break;
    }
    return widget;
  }
}
