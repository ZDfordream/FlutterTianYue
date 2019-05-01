import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tianyue/comic_home/comic_banner.dart';
import 'package:tianyue/comic_home/comic_block_view.dart';
import 'package:tianyue/comic_home/comic_recommend_everyday_view.dart';
import 'package:tianyue/comic_home/comic_update_today_view.dart';
import 'package:tianyue/public.dart';

class ComicHomeScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ComicHomeState();
}

class ComicHomeState extends State<ComicHomeScene> with RouteAware {
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void didPopNext() {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
  }

  @override
  void didPush() {
    super.didPush();
    var timer = Timer(Duration(milliseconds: 1000), () {
      Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
    });
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    scrollController.dispose();
    super.dispose();
  }

  updateStatusBar() {
    if (navAlpha == 1) {
      Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
    } else {
      Screen.updateStatusBarStyle(SystemUiOverlayStyle.light);
    }
  }

  Future<void> fetchData() async {
    try {
      var responseJson = await Request.get(action: 'home_comic');
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
    if (blockList == null || blockList.length == 0) {
      return new Container();
    }
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
}
