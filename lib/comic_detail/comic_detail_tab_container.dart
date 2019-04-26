import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/comic_detail/comic_detail_tab_one.dart';
import 'package:tianyue/comic_detail/comic_detail_tab_three.dart';
import 'package:tianyue/comic_detail/comic_detail_tab_two.dart';
import 'package:tianyue/comic_detail/comic_detail_tab_view.dart';
import 'package:tianyue/public.dart';

class ComicDetailTabContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ComicDetailTabState();
}

class ComicDetailTabState extends State<ComicDetailTabContainer>
    implements OnTabClickListener {
  int _currentItem = 1;

  ComicDetail comicDetail;
  ComicChapter comicChapter;
  List<ComicComment> commentList = [];

  /// 详情数据是否准备完毕
  bool _comicDetailReady = false;

  /// 章节数据是否准备完毕
  bool _comicChapterReady = false;

  /// 评论数据是否准备完毕
  bool _comicCommentReady = false;

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
        _comicDetailReady = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchChapterData() async {
    try {
      var responseJson = await Request.get(action: 'home_comic_chapter');
      comicChapter = ComicChapter.fromJson(responseJson);
      setState(() {
        _comicChapterReady = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> fetchCommentData() async {
    try {
      var responseJson = await Request.get(action: 'home_comic_comment');
      responseJson["commentList"].forEach((data) {
        commentList.add(ComicComment.fromJson(data));
      });
      setState(() {
        _comicCommentReady = true;
      });
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
        widget = ComicChapterTabTwo(comicChapter);
        break;
      case 2:
        widget = ComicCommentTabThree(commentList);
        break;
    }
    return widget;
  }

  @override
  Widget build(BuildContext context) {
    var width = Screen.width;
    if (!_comicDetailReady || !_comicChapterReady || !_comicCommentReady) {
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
