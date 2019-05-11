import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class HomeBanner extends StatelessWidget {
  final List urls;

  HomeBanner(this.urls);

  @override
  Widget build(BuildContext context) {
    if (CollectionsUtils.size(urls) == 0) {
      return SizedBox();
    }

    return Container(
      color: Colors.white,
      child: CarouselSlider(
        items: urls.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: Screen.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Image.network(
                  url,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
        aspectRatio: 2,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlay: true,
      ),
    );
  }
}
