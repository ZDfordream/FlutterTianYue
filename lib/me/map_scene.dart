import 'package:flutter/material.dart';
import 'package:tianyue/widget/loading_indicator.dart';

class MapScene extends StatefulWidget {

  @override
  MapSceneState createState() => MapSceneState();
}

class MapSceneState extends State<MapScene> {

  bool isDataReady = false;
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(milliseconds: 3000), () {
      pageState = PageState.Content;
    });

    setState(() {
      isDataReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataReady) {
      return LoadingIndicator(
        pageState,
      );
    }
    return Column(children: <Widget>[
      Expanded(child: AndroidView(viewType: "AMapView"),)
    ],
    mainAxisAlignment: MainAxisAlignment.center);
  }
}
