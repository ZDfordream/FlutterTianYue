import 'package:tianyue/model/comic_block.dart';

class ComicChapter {
  String updateTime;
  List<String> categoryList;
  String actionName;
  //骚年们都在看
  List<ComicBlock> recommendList;

  ComicChapter.fromJson(Map data) {
    updateTime = data['updateTime'];
    categoryList = data['categoryList'];
    actionName = data['actionName'];
    recommendList = data['recommendList'];
  }
}
