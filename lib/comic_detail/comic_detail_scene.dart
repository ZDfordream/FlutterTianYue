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

class ComicDetailState extends State<ComicDetailScene> with RouteAware{
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

  @override
  Widget build(BuildContext context) {
    return Container(
        color: TYColor.white,
        child: new Stack(
          children: <Widget>[
            ListView.builder(
              padding: EdgeInsets.only(top: 0),
              controller: scrollController,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return buildWidget(index);
              },
            ),
            Positioned(
              bottom: 0,
              child: Text("bottom"),
            ),
          ],
        ));
  }
}
