import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class ComicCommentTabThree extends StatefulWidget {
  final ScrollController _scrollController;

  ComicCommentTabThree(this._scrollController);

  @override
  ComicCommentTabThreeState createState() => ComicCommentTabThreeState();
}

class ComicCommentTabThreeState extends State<ComicCommentTabThree>
    with AutomaticKeepAliveClientMixin {
  List<ComicComment> commentList = [];
  ScrollController scrollController2 = ScrollController();
  int _pageCount = 1;

  @override
  void initState() {
    super.initState();
    _fetchCommentData();
    widget._scrollController.addListener(() {
      if (widget._scrollController.position.pixels ==
          widget._scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        _getMore();
      }
    });
  }

  Future<void> _getMore() async {
    _pageCount++;
    var responseJson = await Request.get(action: 'home_comic_comment');
    responseJson["commentList"].forEach((data) {
      print("加载更多----");
      print("大小：" + CollectionsUtils.size(commentList).toString());
      var comicComment = ComicComment.fromJson(data);
      comicComment.content = comicComment.content + _pageCount.toString();
      commentList.add(comicComment);
    });
    eventBus.emit(EventDetailLoadMore);
    //setState(() {});
  }

  Future<void> _fetchCommentData() async {
    try {
      var responseJson = await Request.get(action: 'home_comic_comment');
      responseJson["commentList"].forEach((data) {
        commentList.add(ComicComment.fromJson(data));
      });
      setState(() {});
    } catch (e) {
      print(e.toString());
    }
  }

  Widget buildChapterWidget(ComicComment comment) {
    var width = Screen.width;
    return Column(children: <Widget>[
      SizedBox(height: 10),
      Row(
        children: <Widget>[
          SizedBox(width: 10),
          CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(
                comment.avatar,
              )),
          SizedBox(width: 10),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(comment.userName,
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xffe86a3e),
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none)),
                Text(comment.time,
                    style: TextStyle(
                        fontSize: 12,
                        color: TYColor.gray,
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.none)),
              ]),
        ],
      ),
      Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.fromLTRB(50, 10, 10, 10),
          child: Text(comment.content,
              style: TextStyle(
                  fontSize: 16,
                  color: TYColor.darkGray,
                  fontWeight: FontWeight.w300,
                  decoration: TextDecoration.none))),
      Container(
        height: 0.8,
        width: width,
        margin: EdgeInsets.only(left: 20),
        color: Color(0xffe1e1e1),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (CollectionsUtils.isEmpty(commentList)) {
      return Container();
    }
    var commentChildren =
        commentList.map((comment) => buildChapterWidget(comment)).toList();
    commentChildren.add(buildLoadProgress());
    return Container(
        child: ListView.builder(
      itemCount: CollectionsUtils.size(commentList) + 1,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index < CollectionsUtils.size(commentList)) {
          return buildChapterWidget(commentList[index]);
        } else {
          return buildLoadProgress();
        }
      },
      cacheExtent: 5,
    ));
  }

  Widget buildLoadProgress() {
    var width = Screen.width;
    return Container(
      child: Text("正在加载更多...",
          style: TextStyle(color: TYColor.darkGray, fontSize: 16)),
      width: width,
      height: 50,
      alignment: Alignment.center,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
