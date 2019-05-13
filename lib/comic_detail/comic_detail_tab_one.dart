import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/comic_home/comic_block_item_view.dart';
import 'package:tianyue/public.dart';

class ComicDetailTabOne extends StatelessWidget {
  final ComicDetail comicDetail;

  ComicDetailTabOne(this.comicDetail);

  @override
  Widget build(BuildContext context) {
    if (comicDetail == null ||
        CollectionsUtils.isEmpty(comicDetail.recommendList)) {
      return Container();
    }
    var children = comicDetail.recommendList
        .map((comicItem) => ComicBlockItemView(comicItem, Color(0xFFF5F5EE)))
        .toList();
    /// 没有SingleChildScrollView，布局可能越界
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                child: Text(comicDetail.detail,
                    style: TextStyle(
                        fontSize: 14,
                        color: TYColor.mediumGray,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none)),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 20)),
            Container(
              child: Text("骚年们都在看",
                  style: TextStyle(
                      fontSize: 15,
                      color: TYColor.gray,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.none)),
              padding: EdgeInsets.only(left: 10),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 15, 0, 15),
              child: Wrap(spacing: 15, runSpacing: 15, children: children),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        /// 处理滑动冲突
        physics: NeverScrollableScrollPhysics());
  }
}
