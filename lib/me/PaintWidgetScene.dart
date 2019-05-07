import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/widget/CircleProgress.dart';
import 'package:tianyue/widget/loading_indicator.dart';

class PaintWidgetScene extends StatefulWidget {
  @override
  _PaintWidgetSceneState createState() => _PaintWidgetSceneState();
}

class _PaintWidgetSceneState extends State<PaintWidgetScene>
    with TickerProviderStateMixin {
  AnimationController _animationController;

  bool isDataReady = false;
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(milliseconds: 2000), () {
      pageState = PageState.Content;
    });

    setState(() {
      isDataReady = true;
      _animationController =
          new AnimationController(vsync: this, duration: Duration(seconds: 3));
      _animationController.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          /// 可以执行类似跳转首页逻辑
          Toast.show("done!");
        }
      });
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataReady) {
      return LoadingIndicator(
        pageState,
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('自定义widget'), elevation: 0.0),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: TYColor.white,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          AnimatedBuilder(
            animation: _animationController,
            builder: (BuildContext context, Widget child) {
              return CircleProgress(
                colors: [Colors.orange[700], Colors.orange[200]],
                radius: 30.0,
                stokeWidth: 4.0,
                value: _animationController.value,
              );
            },
          ),
          Text(
            "跳过",
            style: TextStyle(
                color: TYColor.primary,
                fontSize: 16,
                decoration: TextDecoration.none),
          ),
        ]),
      ),
    );
  }
}
