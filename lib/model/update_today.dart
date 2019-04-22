class UpdateToday {
  String cover;
  String title;
  String author;
  String newUpdate;

  UpdateToday.fromJson(Map data) {
    cover = data['cover'];
    title = data['title'];
    author = data['author'];
    newUpdate = data['newUpdate'];
  }
}
