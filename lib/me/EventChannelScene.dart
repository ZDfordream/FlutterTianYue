import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/widget/loading_indicator.dart';

class EventChannelScene extends StatefulWidget {
  @override
  _EventChannelSceneState createState() => _EventChannelSceneState();
}

class _EventChannelSceneState extends State<EventChannelScene>
    with TickerProviderStateMixin {

  bool isDataReady = false;
  PageState pageState = PageState.Loading;
  static const stream = EventChannel('com.yourcompany.eventchannelsample/stream');
  StreamSubscription _timerSubscription;

  int _timer = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(milliseconds: 2000), () {
      pageState = PageState.Content;
    });
    _timerSubscription = stream.receiveBroadcastStream().listen(_updateTimer); // 添加监听

    setState(() {
      isDataReady = true;
    });
  }

  void _updateTimer(timer) {
    debugPrint("Timer $timer");
    setState(() => _timer = timer);
  }

  @override
  void dispose() {
    _timerSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataReady) {
      return LoadingIndicator(
        pageState,
      );
    }
    return Scaffold(
      appBar: AppBar(title: Text('EventChannel'), elevation: 0.0),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: TYColor.white,
        child: Stack(alignment: Alignment.center, children: <Widget>[
          Text(
            "Timer $_timer",
            style: TextStyle(
                color: TYColor.primary,
                fontSize: 30,
                decoration: TextDecoration.none),
          ),
        ]),
      ),
    );
  }
}
