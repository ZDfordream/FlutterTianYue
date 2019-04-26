import 'package:tianyue/model/comic_block.dart';

class ComicChapter {
  String updateTime;
  List<String> categoryList = [];
  String actionName;
  //骚年们都在看
  List<ComicBlock> recommendList = [];

  ComicChapter.fromJson(Map data) {
    updateTime = data['updateTime'];
    data["categoryList"].forEach((chapterName) {
      categoryList.add(chapterName);
    });
    actionName = data['actionName'];
    data["recommendList"].forEach((item) {
      ComicBlock comicBlock = ComicBlock.fromJson(item);
      recommendList.add(comicBlock);
    });
  }
}
