import 'package:tianyue/model/comic_block.dart';

class ComicDetail {
  String detail;

  //骚年们都在看
  List<ComicBlock> recommendList;

  ComicDetail.fromJson(Map data) {
    detail = data['detail'];
    recommendList = data['recommendList'];
  }
}
