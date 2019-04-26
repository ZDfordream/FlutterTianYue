import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/comic_home/comic_block_item_view.dart';
import 'package:tianyue/public.dart';

class ComicCommentTabThree extends StatelessWidget {
  final List<ComicComment> commentList;

  ComicCommentTabThree(this.commentList);

  @override
  Widget build(BuildContext context) {
    if (CollectionsUtils.isEmpty(commentList)) {
      return Container();
    }
    var chapterChildren =
        commentList.map((comment) => buildChapterWidget(comment)).toList();

    return Column(
      children: chapterChildren,
    );
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
}
