import 'comic_block.dart';
import 'recommend_every_day.dart';
import 'update_today.dart';

class Comic{
  /// banner
  List<String> banner;

  /// 无良推荐
  List<ComicBlock> blockList;

  /// 每日一推
  RecommendEveryDay recommendEveryDay;

  /// 今日我更新
  List<UpdateToday> updateTodayList;

  Comic.fromJson(Map data) {
    banner = data['banner'];
    blockList = data['blockList'];
    recommendEveryDay = data['recommendEveryDay'];
    updateTodayList = data['updateTodayList'];
  }
}
