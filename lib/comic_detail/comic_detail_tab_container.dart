import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/comic_detail/comic_detail_tab_one.dart';
import 'package:tianyue/comic_detail/comic_detail_tab_three.dart';
import 'package:tianyue/comic_detail/comic_detail_tab_two.dart';
import 'package:tianyue/public.dart';

class ComicDetailTabContainer extends StatefulWidget {
  final TabController tabController;

  ComicDetailTabContainer(
      {Key key, @required this.tabController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ComicDetailTabState();
}

class ComicDetailTabState extends State<ComicDetailTabContainer> {
  ComicDetail comicDetail;
  ComicChapter comicChapter;

  /// 详情数据是否准备完毕
  bool _comicDetailReady = false;

  /// 章节数据是否准备完毕
  bool _comicChapterReady = false;

  @override
  void initState() {
    super.initState();
    fetchDetailData();
    fetchChapterData();
  }

  Future<void> fetchDetailData() async {
    try {
      var responseJson = await Request.get(url: 'home_comic_detail');
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
      var responseJson = await Request.get(url: 'home_comic_chapter');
      comicChapter = ComicChapter.fromJson(responseJson);
      setState(() {
        _comicChapterReady = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_comicDetailReady || !_comicChapterReady) {
      return Container();
    }
    return TabBarView(
      children: <Widget>[
        ComicDetailTabOne(comicDetail),
        ComicChapterTabTwo(comicChapter),
        ComicCommentTabThree(),
      ],
      controller: widget.tabController,
    );
  }
}
