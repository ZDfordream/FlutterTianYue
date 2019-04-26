import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tianyue/comic_detail/comic_detail_overview_view.dart';
import 'package:tianyue/comic_detail/comic_detail_tab_container.dart';
import 'package:tianyue/public.dart';

class ComicDetailScene extends StatefulWidget {
  final String url;

  ComicDetailScene(this.url);

  @override
  State<StatefulWidget> createState() => ComicDetailState();
}

class ComicDetailState extends State<ComicDetailScene> with RouteAware {
  ScrollController scrollController = ScrollController();

  bool isOverviewDataReady = false;

  /// 顶部介绍
  ComicOverview comicOverview;

  /// 详情
  ComicDetail comicDetail;

  /// 目录
  ComicChapter comicChapter;

  /// 评论
  List<ComicComment> commentList = [];

  int _currentIndex = 1;

  var width = Screen.width;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didPopNext() {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
  }

  @override
  void didPush() {
    super.didPush();
    Timer(Duration(milliseconds: 1000), () {
      Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
    });
  }

  Future<void> fetchData() async {
    try {
      var responseJson = await Request.get(action: 'home_comic_overview');
      comicOverview = ComicOverview.fromJson(responseJson);
      setState(() {
        isOverviewDataReady = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Widget buildWidget(int index) {
    Widget widget;
    switch (index) {
      case 0:
        widget = ComicDetailOverViewView(comicOverview);
        break;
      case 1:
        widget = ComicDetailTabContainer();
        break;
    }
    return widget;
  }

  Widget buildBottomWidget() {
    Widget widget;
    switch (_currentIndex) {
      case 0:
        widget = getBottomReader();
        break;
      case 1:
        widget = getBottomReader();
        break;
      case 2:
        widget = Container(
          width: width,
          height: 60,
          child: Image.asset(
            'img/detail_bottom_comment.png',
            fit: BoxFit.contain,
          ),
          alignment: Alignment.center,
        );
        break;
    }
    return widget;
  }

  Widget getBottomReader() {
    return Container(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              width: 120,
              height: 30,
              child: Image.asset(
                'img/detail_bottom_read.png',
                fit: BoxFit.contain,
              ),
              alignment: Alignment.center,
            ),
          ),
          Material(
            child: new InkWell(
                onTap: () => AppNavigator.pushComicReader(context, ""),
                child: Container(
                    child: Text(
                      "开始阅读",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: TYColor.white,
                          decoration: TextDecoration.none),
                    ),
                    width: width * 0.4,
                    height: 40,
                    margin: EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: TYColor.primary),
                    alignment: Alignment.center)),
          )
        ],
      ),
      height: 60,
      width: width,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: TYColor.white,
        child: new Stack(
          children: <Widget>[
            Container(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 0),
                controller: scrollController,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return buildWidget(index);
                },
              ),
              margin: EdgeInsets.only(bottom: 60),
            ),
            Positioned(
              bottom: 60,
              child: Container(
                  width: width, height: 0.7, color: Color(0xffe1e1e1)),
            ),
            Positioned(
              bottom: 0,
              child: buildBottomWidget(),
            ),
          ],
        ));
  }
}
