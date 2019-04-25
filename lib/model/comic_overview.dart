class ComicOverview {
  String cover;
  String title;
  String score;
  String tag;
  String author;
  String popularity;
  String monthTicket;

  ComicOverview.fromJson(Map data) {
    cover = data['cover'];
    title = data['title'];
    score = data['score'];
    tag = data['tag'];
    author = data['author'];
    popularity = data['popularity'];
    monthTicket = data['monthTicket'];
  }
}
