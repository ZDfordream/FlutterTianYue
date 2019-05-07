import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

// 帧动画Image
class FrameAnimationImage extends StatefulWidget {
  final double width;
  final double height;
  int interval = 200;

  FrameAnimationImage({this.width = 150, this.height = 150, this.interval = 200});

  @override
  State<StatefulWidget> createState() => FrameAnimationImageState();
}

class FrameAnimationImageState extends State<FrameAnimationImage>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  int interval = 200;
  List<String> _assetList = [
    'img/loading_1.png',
    'img/loading_2.png',
    'img/loading_3.png',
    'img/loading_4.png'
  ];

  @override
  void initState() {
    super.initState();

    if (widget.interval != null) {
      interval = widget.interval;
    }
    final int imageCount = _assetList.length;
    final int maxTime = interval * imageCount;

    _controller = new AnimationController(
        duration: Duration(milliseconds: maxTime), vsync: this);
    _controller.addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.forward(from: 0.0); // 完成后重新开始
      }
    });

    _animation = new Tween<double>(begin: 0, end: imageCount.toDouble())
        .animate(_controller)
          ..addListener(() {
            setState(() {
            });
          });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int ix = _animation.value.floor() % _assetList.length;

    List<Widget> images = [];
    // 把所有图片都加载进内容，否则每一帧加载时会卡顿
    for (int i = 0; i < _assetList.length; ++i) {
      if (i != ix) {
        images.add(Container(
            color: TYColor.white,
            child: Image.asset(
              _assetList[i],
              width: 0,
              height: 0,
            ),
            alignment: Alignment.center,
            height: Screen.height,
            width: Screen.width));
      }
    }

    images.add(Container(
        color: TYColor.white,
        child: Image.asset(
          _assetList[ix],
          width: widget.width,
          height: widget.height,
        ),
        alignment: Alignment.center,
        height: Screen.height,
        width: Screen.width));

    return Stack(alignment: AlignmentDirectional.center, children: images);
  }
}
