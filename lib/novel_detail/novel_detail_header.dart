import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui' as ui;

import 'package:tianyue/public.dart';

class NovelDetailHeader extends StatelessWidget {
  final Novel novel;

  NovelDetailHeader(this.novel);

  @override
  Widget build(BuildContext context) {
    var width = Screen.width;
    return Container(
      width: width,
      child: Stack(
        children: <Widget>[buildContent(context)],
      ),
    );
  }

  Widget buildContent(BuildContext context) {
    var width = Screen.width;
    return Container(
      width: width,
      padding: EdgeInsets.fromLTRB(15, 10 + Screen.topSafeHeight, 10, 0),
      color: TYColor.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          NovelCoverImage(novel.imgUrl, width: 100, height: 133),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(novel.name,
                    style: TextStyle(
                        fontSize: fixedFontSize(18),
                        color: TYColor.darkGray,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(novel.author,
                    style: TextStyle(
                        fontSize: fixedFontSize(14), color: TYColor.darkGray)),
                SizedBox(height: 10),
                Text('${novel.wordCount}万字 ${novel.price}书豆/千字',
                    style: TextStyle(
                        fontSize: fixedFontSize(14), color: TYColor.darkGray)),
                SizedBox(height: 10),
                buildScore(),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset('img/read_icon_vip.png'),
                    Expanded(
                      child: Text(
                        ' 续费包月会员，万本小说免费读 >',
                        style: TextStyle(
                            fontSize: fixedFontSize(14),
                            color: TYColor.primary),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildScore() {
    List<Widget> children = [
      Text('评分：${novel.score}分  ',
          style:
              TextStyle(fontSize: fixedFontSize(14), color: TYColor.primary))
    ];

    var star = novel.score;

    for (var i = 0; i < 5; i++) {
      if (star < i) {
        break;
      }
      var img;
      if (star <= i + 0.5) {
        img = Image.asset('img/detail_star_half.png');
      } else {
        img = Image.asset('img/detail_star.png');
      }
      children.add(img);
      children.add(SizedBox(width: 5));
    }
    return Row(
      children: children,
    );
  }
}
