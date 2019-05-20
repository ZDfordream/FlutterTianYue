import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/stream/CounterStream.dart';
import 'package:tianyue/widget/loading_indicator.dart';

class StreamCounterScene extends StatefulWidget {
  @override
  _StreamCounterSceneState createState() =>
      _StreamCounterSceneState(CounterStream());
}

class _StreamCounterSceneState extends State<StreamCounterScene> {
  int _number = 0;

  final CounterStream counterStream;

  _StreamCounterSceneState(this.counterStream);

  void _incrementCounter() {
    counterStream.increment(_number);
  }

  @override
  void initState() {
    counterStream.streamOut.listen((_count) {
      setState(() {
        _number = _count;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stream Api"),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_number',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
