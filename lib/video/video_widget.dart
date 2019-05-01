import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  final String previewImgUrl; //预览图片的地址
  final bool showProgressBar; //是否显示进度条
  final bool showProgressText; //是否显示进度文本
  final int positionTag;

  VideoWidget(this.url,
      {Key key,
      this.previewImgUrl: '',
      this.showProgressBar = true,
      this.showProgressText = true,
      this.positionTag})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VideoWidgetState();
  }
}

class VideoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  bool _hideActionButton = true;
  bool videoPrepared = false; //视频是否初始化

  @override
  void initState() {
    super.initState();
    eventBus.on(EventVideoPlayPosition + widget.positionTag.toString(), (arg) {
      if (arg == widget.positionTag) {
        _controller.play();
        videoPrepared = true;
      } else {
        _controller.pause();
      }
      setState(() {});
    });

    _controller = VideoPlayerController.asset(widget.url)
      ..initialize()
      ..setLooping(true).then((_) {
        if (widget.positionTag == 0) {
          _controller.play();
          videoPrepared = true;
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    eventBus.off(EventVideoPlayPosition + widget.positionTag.toString());
    _controller.dispose(); //释放播放器资源
  }

  Widget getPreviewImg() {
    return Offstage(
        offstage: videoPrepared,
        child: Image.asset(
          widget.previewImgUrl,
          fit: BoxFit.cover,
          width: Screen.width,
          height: Screen.height,
        ));
  }

  getControlView() {
    return Offstage(
      offstage: _hideActionButton,
      child: Stack(
        children: <Widget>[
          Align(
            child: Container(
                child: Image.asset('img/ic_playing.png'),
                height: 50,
                width: 50),
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GestureDetector(
        child: Stack(
          children: <Widget>[
            VideoPlayer(_controller),
            getControlView(),
          ],
        ),
        onTap: () {
          if (_controller.value.isPlaying) {
            _controller.pause();
            _hideActionButton = false;
          } else {
            _controller.play();
            videoPrepared = true;
            _hideActionButton = true;
          }
          setState(() {});
        },
      ),
      getPreviewImg(),
    ]);
  }
}
