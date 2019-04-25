import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class ComicDetailTabScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ComicDetailTabState();
}

class ComicDetailTabState extends State<ComicDetailTabScene> {
  PageController _controller;
  int _currentItem = 0;
  static List<Container> pages = [
    Container(
      width: double.maxFinite,
      height: 100,
      child: Text("qq"),
    ),
    Container(
      width: double.maxFinite,
      height: 100,
      child: Text("qq"),
    ),
    Container(
      width: double.maxFinite,
      height: 100,
      child: Text("qq"),
    )
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = Screen.width;
    return DefaultTabController(
        length: 3,
        child: Column(children: <Widget>[
          Container(
            child: AppBar(
              brightness: Brightness.light,
              title: Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TabBar(
                  labelColor: TYColor.darkGray,
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  unselectedLabelColor: TYColor.gray,
                  indicatorColor: TYColor.secondary,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: 3,
                  indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
                  tabs: [
                    Tab(text: '精选'),
                    Tab(text: '女生'),
                    Tab(text: '男生'),
                  ],
                ),
              ),
              backgroundColor: TYColor.white,
              elevation: 0,
            ),
            width: 200,
            height: 100,
          ),
          Container(
            child: TabBarView(children: pages),
            width: width,
            height: 900,
          ),
        ]));
  }
}
