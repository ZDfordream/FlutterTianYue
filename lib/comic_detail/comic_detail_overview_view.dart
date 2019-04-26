import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class ComicDetailOverViewView extends StatelessWidget {
  final ComicOverview comicOverview;

  ComicDetailOverViewView(this.comicOverview);

  @override
  Widget build(BuildContext context) {
    if (comicOverview == null) {
      return Container();
    }
    var width = Screen.width;
    var height = width * 0.55;
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: <Widget>[
          NovelCoverImage(
            comicOverview.cover,
            width: width,
            height: height,
          ),
          BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: new Container(
              color: Colors.transparent.withOpacity(0),
              width: width,
              height: height,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Row(
              children: <Widget>[
                SizedBox(width: 40),
                NovelCoverImage(
                  comicOverview.cover,
                  width: width * 0.34,
                  height: width * 0.46,
                ),
                SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Text(comicOverview.title,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none)),
                      SizedBox(width: 5),
                      Container(
                        child: Text(
                          comicOverview.score,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.white,
                              decoration: TextDecoration.none),
                          textAlign: TextAlign.center,
                        ),
                        decoration: BoxDecoration(
                          color: TYColor.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        width: 24,
                        height: 24,
                      )
                    ]),
                    SizedBox(width: 20),
                    Text(comicOverview.tag,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none)),
                    Text(comicOverview.author,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none)),
                    Text("人气：${comicOverview.popularity}",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none)),
                    Text("月票：${comicOverview.monthTicket}",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.none)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
