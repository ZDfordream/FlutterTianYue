import 'package:flutter/material.dart';
import 'package:tianyue/comic_home/comic_block_header_view.dart';
import 'package:tianyue/public.dart';

class ComicRecommendEveryDayView extends StatelessWidget {
  final RecommendEveryDay recommendEveryDay;

  ComicRecommendEveryDayView(this.recommendEveryDay);

  @override
  Widget build(BuildContext context) {
    if (recommendEveryDay == null) {
      return Container();
    }
    var width = Screen.width;
    var height = width / 2;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          ComicBlockHeaderView(Constant.recommendEveryDay),
          SizedBox(height: 5),
          Container(
            color: TYColor.white,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: GestureDetector(
              onTap: () {
                AppNavigator.pushComicDetail(context, "");
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  NovelCoverImage(
                    recommendEveryDay.cover,
                    width: width,
                    height: height,
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 15),
                      Text(
                        recommendEveryDay.title,
                        style: TextStyle(fontSize: 17, fontWeight:FontWeight.w600,color: Color(0xff535252)),
                        textAlign: TextAlign.center,
                      ),
                      Expanded(child: Container()),
                      Text(recommendEveryDay.author,
                          style:
                          TextStyle(fontSize: 14, color: Color(0xffC5C5C5))),
                      SizedBox(width: 15),
                    ],
                  ),
                  SizedBox(height: 6),
                ],
              ),
            ),
          ),
          Container(
            height: 10,
          )
        ],
      ),
    );
  }
}
