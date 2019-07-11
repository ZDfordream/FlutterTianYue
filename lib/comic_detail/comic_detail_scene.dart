import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tianyue/comic_detail/comic_detail_overview_view.dart';
import 'package:tianyue/comic_detail/comic_detail_tab_container.dart';
import 'package:tianyue/public.dart';
import 'dart:math' as math;

import 'package:tianyue/widget/loading_indicator.dart';

class ComicDetailScene extends StatefulWidget {
  final String url;

  ComicDetailScene(this.url);

  @override
  State<StatefulWidget> createState() => ComicDetailState();
}

class ComicDetailState extends State<ComicDetailScene>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

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

  TabController _tabController;

  List<Widget> tabList = [];

  var titleList = ['详情', '目录', '评论'];

  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 1000), () {
      Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
    });

    tabList = _getTabList();
    _tabController = TabController(
        vsync: this, initialIndex: _currentIndex, length: tabList.length);
    _fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  List<Widget> _getTabList() {
    return titleList
        .map((item) => Text(
              '$item',
            ))
        .toList();
  }

  Future<void> _fetchData() async {
    try {
      var responseJson = await Request.get(url: 'home_comic_overview');
      comicOverview = ComicOverview.fromJson(responseJson);

      await Future.delayed(Duration(milliseconds: 2000), () {
        pageState = PageState.Content;
      });

      setState(() {
        isOverviewDataReady = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  /// 失败重试
  _retry() {
    pageState = PageState.Loading;
    setState(() {});
    _fetchData();
  }

  Widget _getBottomReader() {
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
          Container(
            width: width * 0.4,
            height: 40,
            child: RaisedButton(
                /// 水波纹不显示
                splashColor: Colors.transparent,
                disabledTextColor: Color(0xffff0000),
                color: TYColor.primary,
                disabledColor: TYColor.orange,
                onPressed: () => AppNavigator.pushComicReader(context, ""),
                child: Text(
                  "开始阅读",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: TYColor.white,
                      decoration: TextDecoration.none),
                )),
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3), color: TYColor.primary),
          )
        ],
      ),
      height: 60,
      width: width,
    );
  }

  Widget _buildTabBar() {
    return TabBar(
        tabs: tabList,
        labelPadding: EdgeInsets.symmetric(horizontal: 25),
        isScrollable: true,
        controller: _tabController,
        indicatorColor: TYColor.primary,
        labelColor: TYColor.primary,

        /// 选中状态文字大小设置不一样，有缩放效果；但，tabList设置了大小会影响此处
        labelStyle: TextStyle(
            fontSize: 20, color: TYColor.primary, fontWeight: FontWeight.w500),
        unselectedLabelColor: Colors.black,
        unselectedLabelStyle: TextStyle(fontSize: 16, color: Colors.black),
        indicatorSize: TabBarIndicatorSize.label);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: DefaultTabController(
          length: titleList.length,
          child: Stack(children: <Widget>[
            Container(
                color: TYColor.white,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: NestedScrollView(
                        headerSliverBuilder:
                            (BuildContext context, bool innerBoxIsScrolled) {
                          return <Widget>[
                            SliverToBoxAdapter(
                              child: Container(
                                color: Colors.white,
                                child: ComicDetailOverViewView(comicOverview),
                              ),
                            ),
                            SliverPersistentHeader(
                                floating: true,
                                pinned: true,
                                delegate: _SliverAppBarDelegate(
                                    maxHeight: Screen.topSafeHeight+30,
                                    minHeight: Screen.topSafeHeight+30,
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: Screen.topSafeHeight),
                                      child: _buildTabBar(),
                                      color: TYColor.white,
                                      alignment: Alignment.center,
                                    ))),
                          ];
                        },
                        body: ComicDetailTabContainer(
                          tabController: _tabController,
                        ),
                      ),
                    ),
                    Container(
                        width: width, height: 0.7, color: Color(0xffe1e1e1)),
                    _getBottomReader(),
                  ],
                )),
            LoadingIndicator(
              pageState,
              retry: _retry,
            ),
          ])),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max((minHeight ?? kToolbarHeight), minExtent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
