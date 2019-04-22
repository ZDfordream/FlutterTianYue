import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tianyue/public.dart';

import 'comic_banner.dart';

class ComicHomeScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ComicHomeState();
}

class ComicHomeState extends State<ComicHomeScene> with RouteAware {
  Comic comic;

  /// banner
  List<String> banner = [];

  /// 无良推荐
  List<BookBlock> blockList = [];

  /// 每日一推
  RecommendEveryDay recommendEveryDay;

  /// 今日我更新
  List<UpdateToday> updateTodayList = [];

  ScrollController scrollController = ScrollController();
  double navAlpha = 0;

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
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      var responseJson = await Request.get(action: 'home_comic');
      //comic = Comic.fromJson(responseJson);
      responseJson["banner"].forEach((data) {
        banner.add(data);
      });
      responseJson["blockList"].forEach((data) {
        blockList.add(BookBlock.fromJson(data));
      });
      responseJson["updateTodayList"].forEach((data) {
        updateTodayList.add(UpdateToday.fromJson(data));
      });
      recommendEveryDay =
          RecommendEveryDay.fromJson(responseJson["recommendEveryDay"]);
      /*banner = comic.banner;
      blockList = comic.blockList;
      recommendEveryDay = comic.recommendEveryDay;
      updateTodayList = comic.updateTodayList;
      print(responseJson.toString());*/
      /*  setState(() {
        this.comic = responseJson;
      });*/
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
            padding: EdgeInsets.fromLTRB(5, Screen.topSafeHeight, 0, 0),
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
    if (banner == null) {
      return new Container();
    }
    Widget widget;
    switch (index) {
      case 0:
        widget = ComicBanner(banner);
        break;
      case 1:
        widget = ComicBanner(banner);
        break;
      case 2:
        widget = ComicBanner(banner);
        break;
      case 3:
        widget = ComicBanner(banner);
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TYColor.white,
      body: Stack(children: [
        RefreshIndicator(
          onRefresh: fetchData,
          color:TYColor.primary,
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
