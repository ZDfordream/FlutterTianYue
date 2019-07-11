import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:tianyue/public.dart';

import 'package:tianyue/book_home/home_scene.dart';
import 'package:tianyue/comic_home/comic_home_scene.dart';
import 'package:tianyue/me/me_scene.dart';
import 'package:tianyue/video/video_scene.dart';
import 'package:tianyue/widget/loading_indicator.dart';

class RootScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RootSceneState();
}

class RootSceneState extends State<RootScene> {
  int _tabIndex = 0;
  bool isFinishSetup = false;
  PageState pageState = PageState.Loading;
  List<Image> _tabImages = [
    Image.asset('img/tab_comic_home_n.png'),
    Image.asset('img/tab_video_home_n.png'),
    Image.asset('img/tab_book_home_n.png'),
    Image.asset('img/tab_mine_n.png'),
  ];
  List<Image> _tabSelectedImages = [
    Image.asset('img/tab_home_comic_p.png'),
    Image.asset('img/tab_video_home_p.png'),
    Image.asset('img/tab_book_home_p.png'),
    Image.asset('img/tab_mine_p.png'),
  ];

  @override
  void initState() {
    super.initState();

    setupApp();

    eventBus.on(EventUserLogin, (arg) {
      setState(() {});
    });

    eventBus.on(EventUserLogout, (arg) {
      setState(() {});
    });

    eventBus.on(EventToggleTabBarIndex, (arg) {
      setState(() {
        _tabIndex = arg;
      });
    });
  }

  @override
  void dispose() {
    eventBus.off(EventUserLogin);
    eventBus.off(EventUserLogout);
    eventBus.off(EventToggleTabBarIndex);
    super.dispose();
  }

  setupApp() async {
    preferences = await SharedPreferences.getInstance();
    await Future.delayed(Duration(milliseconds: 2000), () {
      pageState = PageState.Content;
    });
    setState(() {
      isFinishSetup = true;
    });
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('提示'),
        content: new Text('客官，确定退出app?'),
        actions: <Widget>[
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('放弃'),
          ),
          new FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('退出'),
          ),
        ],
      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {
    if (!isFinishSetup) {
      return LoadingIndicator(
        pageState,
      );
    }
    return WillPopScope(
      onWillPop: _onWillPop, // look here!
      child: Scaffold(
        body: IndexedStack(
          children: <Widget>[
            ComicHomeScene(),
            VideoScene(),
            HomeScene(),
            MeScene(),
          ],
          index: _tabIndex,
        ),
        bottomNavigationBar: CupertinoTabBar(
          backgroundColor: Colors.white,
          activeColor: TYColor.primary,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: getTabIcon(0)),
            BottomNavigationBarItem(icon: getTabIcon(1)),
            BottomNavigationBarItem(icon: getTabIcon(2)),
            BottomNavigationBarItem(icon: getTabIcon(3)),
          ],
          currentIndex: _tabIndex,
          onTap: (index) {
            setState(() {
              _tabIndex = index;
            });
          },
        ),
      ),
    );
  }

  Image getTabIcon(int index) {
    if (index == _tabIndex) {
      return _tabSelectedImages[index];
    } else {
      return _tabImages[index];
    }
  }
}
