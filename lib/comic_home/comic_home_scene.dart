import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tianyue/comic_home/comic_banner.dart';
import 'package:tianyue/comic_home/comic_block_view.dart';
import 'package:tianyue/comic_home/comic_recommend_everyday_view.dart';
import 'package:tianyue/comic_home/comic_update_today_view.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/widget/loading_indicator.dart';

class ComicHomeScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ComicHomeState();
}

class ComicHomeState extends State<ComicHomeScene> with AutomaticKeepAliveClientMixin{
  Comic comic;

  /// banner
  List<String> banner = [];

  /// 无良推荐
  List<ComicBlock> blockList = [];

  /// 每日一推
  RecommendEveryDay recommendEveryDay;

  /// 今日我更新
  List<UpdateToday> updateTodayList = [];

  ScrollController scrollController = ScrollController();
  double navAlpha = 0;

  /// 是否请求数据完毕
  bool isDataReady = false;

  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();

    fetchData();
    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (navAlpha != 0) {
          setState(() {
            navAlpha = 0;
          });
        }
      } else if (offset < 50) {
        setState(() {
          navAlpha = 1 - (50 - offset) / 50;
        });
      } else if (navAlpha != 1) {
        setState(() {
          navAlpha = 1;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  Future<void> fetchData() async {
    try {

      await Future.delayed(Duration(milliseconds: 2000), () {
        pageState = PageState.Content;
      });

      var responseJson = await Request.get(url: 'home_comic');
      banner.clear();
      responseJson["banner"].forEach((data) {
        banner.add(data);
      });
      blockList.clear();
      responseJson["blockList"].forEach((data) {
        blockList.add(ComicBlock.fromJson(data));
      });
      updateTodayList.clear();
      responseJson["updateTodayList"].forEach((data) {
        updateTodayList.add(UpdateToday.fromJson(data));
      });
      recommendEveryDay =
          RecommendEveryDay.fromJson(responseJson["recommendEveryDay"]);
      setState(() {
        isDataReady = true;
      });
    } catch (e) {
      print(e.toString());
      Toast.show(e.toString());
    }
  }

  /// 失败重试
  _retry() {
    pageState = PageState.Loading;
    setState(() {});
    fetchData();
  }

  Widget buildActions(Color iconColor) {
    return Row(children: <Widget>[
      Container(
        height: kToolbarHeight,
        width: 44,
        child: Image.asset('img/actionbar_checkin.png', color: iconColor),
      ),
      Container(
        height: kToolbarHeight,
        width: 44,
        child: Image.asset('img/actionbar_search.png', color: iconColor),
      ),
      SizedBox(width: 15)
    ]);
  }

  Widget buildNavigationBar() {
    return Stack(
      children: <Widget>[
        Positioned(
          right: 0,
          child: Container(
            margin: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
            child: buildActions(TYColor.white),
          ),
        ),
        Opacity(
          opacity: navAlpha,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, Screen.topSafeHeight, 0, 0),
            height: Screen.navigationBarHeight,
            color: TYColor.white,
            child: Row(
              children: <Widget>[
                SizedBox(width: 103),
                Expanded(
                  child: Text(
                    '腾讯动漫',
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: TYColor.primary),
                    textAlign: TextAlign.center,
                  ),
                ),
                buildActions(TYColor.primary),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildModule(BuildContext context, int index) {
    Widget widget;
    switch (index) {
      case 0:
        widget = ComicBanner(banner);
        break;
      case 1:
        widget = ComicBlockView(blockList);
        break;
      case 2:
        widget = ComicRecommendEveryDayView(recommendEveryDay);
        break;
      case 3:
        widget = ComicUpdateTodayView(updateTodayList);
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    if (blockList == null || blockList.length == 0) {
      return LoadingIndicator(
        pageState,
        retry: _retry,
      );
    }
    return Scaffold(
      backgroundColor: TYColor.comicBg,
      body: Stack(children: [
        RefreshIndicator(
          onRefresh: fetchData,
          color: TYColor.primary,
          child: ListView.builder(
            padding: EdgeInsets.only(top: 0),
            controller: scrollController,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return buildModule(context, index);
            },
          ),
        ),
        buildNavigationBar(),
      ]),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
