class ComicComment {
  String avatar;
  String userName;
  String time;
  String content;

  ComicComment.fromJson(Map data) {
    avatar = data['avatar'];
    userName = data['userName'];
    time = data['time'];
    content = data['content'];
  }
}
