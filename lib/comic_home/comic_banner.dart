import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ComicBanner extends StatelessWidget {
  final List<String> imgList;

  ComicBanner(this.imgList);

  @override
  Widget build(BuildContext context) {
    if (imgList.length == 0) {
      return SizedBox();
    }

    return Container(
      color: Colors.white,
      child: CarouselSlider(
        viewportFraction: 1.0,
        aspectRatio: 2.0,
        autoPlay: true,
        enlargeCenterPage: false,
        items: map<Widget>(
          imgList,
              (index, i) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(i), fit: BoxFit.cover),
              ),
            );
          },
        ),
      ),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }

    return result;
  }
}
