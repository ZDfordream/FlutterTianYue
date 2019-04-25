import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/comic_detail/comic_detail_tab_one.dart';
import 'package:tianyue/comic_detail/comic_detail_tab_view.dart';
import 'package:tianyue/public.dart';

class ComicDetailTabContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ComicDetailTabState();
}

class ComicDetailTabState extends State<ComicDetailTabContainer>
    implements OnTabClickListener {
  int _currentItem = 0;

  ComicDetail comicDetail;

  @override
  void initState() {
    super.initState();
    fetchDetailData();
    fetchChapterData();
    fetchCommentData();
  }

  Future<void> fetchDetailData() async {
    try {
      var responseJson = await Request.get(action: 'home_comic_detail');
      comicDetail = ComicDetail.fromJson(responseJson);
      setState(() {
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchChapterData() async {
    try {
      var responseJson = await Request.get(action: 'home_comic_chapter');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchCommentData() async {
    try {
      var responseJson = await Request.get(action: 'home_comic_comment');
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void onTabClick(int index) {
    setState(() {
      _currentItem = index;
    });
  }

  Widget buildTabWidget(int currentItem) {
    Widget widget;
    switch (currentItem) {
      case 0:
        widget = ComicDetailTabOne(comicDetail);
        break;
      case 1:
        widget = ComicDetailTabOne(comicDetail);
        break;
      case 2:
        widget = ComicDetailTabOne(comicDetail);
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    var width = Screen.width;
    if (comicDetail == null) {
      return Container();
    }
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ComicDetailTabView("详情", 0, _currentItem, this),
          ComicDetailTabView("目录", 1, _currentItem, this),
          ComicDetailTabView("评论", 2, _currentItem, this),
        ],
      ),
      Container(width: width, height: 0.5, color: Color(0xffe5e5e5)),
      buildTabWidget(_currentItem)
    ]);
  }
}
