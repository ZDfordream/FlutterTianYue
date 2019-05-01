import 'package:flutter/material.dart';
import 'package:tianyue/app/guide_scene.dart';
import 'package:tianyue/public.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class AppScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tianyue',
      navigatorObservers: [routeObserver],
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
