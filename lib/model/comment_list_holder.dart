import 'package:tianyue/model/comic_comment.dart';

class CommentListHolder{
  List<ComicComment> commentList;

  CommentListHolder.fromJson(Map data) {
    commentList = data['commentList'];
  }
}