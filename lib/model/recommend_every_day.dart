class RecommendEveryDay {
  String cover;
  String title;
  String author;

  RecommendEveryDay.fromJson(Map data) {
    cover = data['cover'];
    title = data['title'];
    author = data['author'];
  }
}
