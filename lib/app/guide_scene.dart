import 'package:flukit/flukit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/app/root_scene.dart';
import 'package:tianyue/public.dart';

/// 引导页
class GuideScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => GuideSceneState();
}

class GuideSceneState extends State<GuideScene> {
  List<String> _guideList = [
    'img/guide1.png',
    'img/guide2.png',
    'img/guide3.png',
    'img/guide4.png',
  ];
  List<String> _guideInfoList = [
    "动漫陪你每一个夜晚",
    "同你去往每个地方",
    "懂你，更懂你所爱",
    "因为在意，所以用心",
  ];

  List<Widget> _bannerList = [];

  @override
  void initState() {
    super.initState();
    _initBannerData();
  }

  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(Stack(
          children: <Widget>[
            Image.asset(
              _guideList[i],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: new Text(
                _guideInfoList[i],
                style: new TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                margin: EdgeInsets.only(bottom: 50.0),
                child: new GestureDetector(
                  onTap: () {
                    _goMain();
                  },
                  child: new Container(
                    width: 185,
                    alignment: Alignment.center,
                    height: 48,
                    child: new Text(
                      '立即启程',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        color: Color(0X19FFFFFF),
                        border:
                            new Border.all(width: 1, color: Colors.white70)),
                  ),
                ),
              ),
            ),
          ],
        ));
      } else {
        _bannerList.add(new Stack(
          children: <Widget>[
            new Image.asset(
              _guideList[i],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            new Center(
              child: new Text(
                _guideInfoList[i],
                style: new TextStyle(fontSize: 20, color: Colors.white),
              ),
            )
          ],
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Swiper(
            autoStart: false,
            circular: false,
            indicator: CircleSwiperIndicator(
                radius: 2,
                spacing: 4,
                padding: EdgeInsets.only(bottom: 32.0),
                itemColor: Colors.white,
                itemActiveColor: TYColor.primary),
            children: _bannerList));
  }

  void _goMain() {
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (BuildContext context) => RootScene()),
        (Route<dynamic> route) => false);
  }
}
