import 'package:flutter/material.dart';

import 'package:tianyue/public.dart';

import 'package:tianyue/novel_detail/novel_detail_scene.dart';
import 'package:tianyue/me/login_scene.dart';
import 'package:tianyue/me/web_scene.dart';
import 'package:tianyue/reader/reader_scene.dart';

class AppNavigator {
  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }

  static pushNovelDetail(BuildContext context, Novel novel) {
    AppNavigator.push(context, NovelDetailScene(novel.id));
  }

  static pushComicDetail(BuildContext context, String url) {

  }

  static pushLogin(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LoginScene();
    }));
  }

  static pushWeb(BuildContext context, String url, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return WebScene(url: url, title: title);
    }));
  }

  static pushReader(BuildContext context, int articleId) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ReaderScene(articleId: articleId);
    }));
  }
}
