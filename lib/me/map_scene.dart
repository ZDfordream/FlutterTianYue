import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';

class MapScene extends StatefulWidget {

  @override
  MapSceneState createState() => MapSceneState();
}

class MapSceneState extends State<MapScene> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(child: AndroidView(viewType: "AMapView"),)
    ],
    mainAxisAlignment: MainAxisAlignment.center);
  }
}
