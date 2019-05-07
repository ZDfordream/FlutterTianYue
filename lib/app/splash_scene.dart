import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tianyue/app/root_scene.dart';
import 'package:tianyue/app/skip_down_time.dart';
import 'package:tianyue/public.dart';

class SplashScene extends StatefulWidget {
  SplashScene({Key key}) : super(key: key);

  @override
  SplashSceneState createState() {
    return new SplashSceneState();
  }
}

class SplashSceneState extends State<SplashScene>
    implements OnSkipClickListener {
  @override
  void initState() {
    super.initState();
    delayedGoHomePage();
  }

  delayedGoHomePage() {
    Future.delayed(new Duration(seconds: 3), () {
      goHomePage();
    });
  }

  goHomePage() {
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (BuildContext context) => RootScene()),
        (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: Image.asset('img/welcome_bg.png'),
                alignment: Alignment.center,
                color: Color(0xFFFFFFFF),
              ),
            ),
          ],
        ),
        Container(
          child: Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: const EdgeInsets.only(top: 50.0, right: 20.0),
              child: SkipDownTimeProgress(
                TYColor.orange,
                22.0,
                new Duration(seconds: 3),
                new Size(25.0, 25.0),
                skipText: "跳过",
                clickListener: this,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onSkipClick() {
    goHomePage();
  }
}
