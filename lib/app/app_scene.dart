import 'package:flutter/material.dart';
import 'package:tianyue/app/guide_scene.dart';
import 'package:tianyue/public.dart';

class AppScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tianyue',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        dividerColor: Color(0xffeeeeee),
        scaffoldBackgroundColor: TYColor.paper,
        textTheme: TextTheme(body1: TextStyle(color: TYColor.darkGray)),
      ),
      home: GuideScene(),
    );
  }
}
