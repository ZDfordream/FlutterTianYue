import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class ComicBanner extends StatefulWidget {
  final List<String> imgList;

  ComicBanner(this.imgList);

  @override
  ComicBannerState createState() => ComicBannerState();
}

class ComicBannerState extends State<ComicBanner> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    if (this.widget.imgList.length == 0) {
      return SizedBox();
    }
    var width = Screen.width;
    return GestureDetector(
        onTap: () {
          AppNavigator.pushComicDetail(context, "");
        },
        child: new Stack(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: CarouselSlider(
                viewportFraction: 1.0,
                aspectRatio: 2.0,
                autoPlay: true,
                enlargeCenterPage: false,
                items: map<Widget>(
                  this.widget.imgList,
                  (index, i) {
                    return NovelCoverImage(
                      i,
                      width: width,
                    );
                  },
                ),
                onPageChanged: (index) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Positioned(
                right: 15,
                bottom: 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: map<Widget>(
                    this.widget.imgList,
                    (index, url) {
                      if (_current == index) {
                        return Container(
                          width: 12.0,
                          height: 6.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: TYColor.primary),
                        );
                      } else {
                        return Container(
                          width: 6.0,
                          height: 6.0,
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 2.0),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xffe1e1e1)),
                        );
                      }
                    },
                  ),
                )),
          ],
        ));
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }
}
