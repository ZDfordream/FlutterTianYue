import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class VideoScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => VideoSceneState();
}

class VideoSceneState extends State<VideoScene> {
  List<String> urlList = [
    'https://wx3.sinaimg.cn/crop.0.0.604.339.360/006QmDx6ly1g2ia60z17lj30gs0b8q5u.jpg',
    'https://wx4.sinaimg.cn/crop.0.0.604.339.360/006QmDx6ly1g2bhtbu3s3j30gs0b8wh9.jpg',
    'https://wx4.sinaimg.cn/crop.0.0.1920.1080.360/6e348924ly1g2is9g114lj21hc0u0hdt.jpg',
    'https://wx3.sinaimg.cn/crop.0.0.1920.1080.360/76e1e855ly1g2jn1ubnm8j21hc0u0gxh.jpg',
    'https://wx1.sinaimg.cn/crop.0.40.960.540.360/006UjVSbly1g2g7t2o5uqj30qo0gon9l.jpg',
    'https://wx4.sinaimg.cn/crop.0.0.1920.1080.360/50214f26ly1g2cqv4vnzrj21hc0u0b29.jpg',
    'https://wx1.sinaimg.cn/crop.0.0.1600.900.360/007mU3qOly1g0n2wq3k2rj318g0p07vp.jpg',
    'https://wx2.sinaimg.cn/crop.0.0.1600.900.360/007mU3qOly1g0eo03wasuj318g0p01kx.jpg',
    'https://wx3.sinaimg.cn/crop.0.0.1600.900.360/007mU3qOly1g06ddkzjgyj318g0p0e81.jpg',
    'https://wx3.sinaimg.cn/crop.0.0.1600.900.360/007mU3qOly1fzydecaeslj318g0p01kx.jpg',
    'https://wx4.sinaimg.cn/crop.0.0.1920.1080.360/76e1e855ly1g13lvk5imsj21hc0u0hdt.jpg',
    'https://wx3.sinaimg.cn/crop.0.0.1920.1080.360/76e1e855ly1g0qxcn13mij21hc0u01kx.jpg',
    'https://wx2.sinaimg.cn/crop.0.139.1053.592.360/006qdyzsly1g1g349c25lj30t90o9tia.jpg',
    'https://wx4.sinaimg.cn/crop.0.75.918.516.360/006qdyzsly1g186z2ch9bj30pi0ilncz.jpg',
  ];

  @override
  void initState() {
    super.initState();
  }

  Widget buildVideoItem(String url) {
    return GestureDetector(
      child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Container(
              color: TYColor.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(url, fit: BoxFit.cover),
                  SizedBox(height: 4),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "#味里故乡#王晓晨 匡牧野山东篇：红瓦绿树间的文艺味道,红瓦绿树间的文艺味道",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          decoration: TextDecoration.none),
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      children: <Widget>[
                        Image.asset("img/play_video.png",
                            color: TYColor.gray, height: 14, width: 14),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                style: new TextStyle(
                                    fontSize: 14,
                                    color: TYColor.primary,
                                    decoration: TextDecoration.none),
                                text: "1.3万"),
                            TextSpan(
                                style: new TextStyle(
                                    fontSize: 14,
                                    color: TYColor.gray,
                                    decoration: TextDecoration.none),
                                text: "次播放")
                          ]),
                        ),
                        Expanded(child: Container()),
                        Text(
                          "1305赞",
                          style: TextStyle(
                              fontSize: 14,
                              color: TYColor.gray,
                              decoration: TextDecoration.none),
                        ),
                      ],
                    ),
                  ),
                ],
              ))),
      onTap: () {
        AppNavigator.pushVideoDetail(context, "此处可传视频id");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var children = urlList.map((url) => buildVideoItem(url)).toList();
    return Scaffold(
      body: GridView(
          padding: EdgeInsets.fromLTRB(10, Screen.topSafeHeight, 10, 10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.03,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10),
          children: children,
          shrinkWrap: true,
          physics: BouncingScrollPhysics()),
    );
  }
}
