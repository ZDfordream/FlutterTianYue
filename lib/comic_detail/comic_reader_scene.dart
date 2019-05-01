import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tianyue/public.dart';

class ComicReaderScene extends StatefulWidget {
  final String url;

  ComicReaderScene(this.url);

  @override
  ComicReaderState createState() => ComicReaderState();
}

class ComicReaderState extends State<ComicReaderScene> with RouteAware {
  ScrollController scrollController = ScrollController();

  bool isDataReady = false;
  List<String> imageList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void didPopNext() {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
  }

  @override
  void didPush() {
    super.didPush();
    Timer(Duration(milliseconds: 1000), () {
      Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
    });
  }

  Future<void> fetchData() async {
    try {
      imageList.clear();
      var responseJson = await Request.get(action: 'home_comic_image_list');
      responseJson["comicPictureList"].forEach((data) {
        imageList.add(data);
      });
      setState(() {
        isDataReady = true;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Widget buildWidget(int index) {
    return NovelCoverImage(imageList[index], fit: BoxFit.fitWidth);
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataReady) {
      return Container();
    }
    return Container(
        color: TYColor.white,
        child: new Stack(
          children: <Widget>[
            ListView.builder(
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.only(top: 0),
              controller: scrollController,
              itemCount: CollectionsUtils.size(imageList),
              itemBuilder: (BuildContext context, int index) {
                return buildWidget(index);
              },
              cacheExtent: 10,
            )
          ],
        ));
  }
}
