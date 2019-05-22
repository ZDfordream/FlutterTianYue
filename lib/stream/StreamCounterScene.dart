import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
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

    // future demo
    _futureDemo();

    // stream demo
    _publishSubjectDemo();

    // rxDart demo
    _rxDartDemo();

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

  /// 演示异步编程future的用法
  void _futureDemo() {
    Future.delayed(Duration(seconds: 2), () {
      // 执行一些列操作
      // ...
      return "number";
    })
        .then((val) => print('接收到数据:' + val))
        .whenComplete(() => print('complete'))
        .catchError(() => print('error'));
  }

  void _publishSubjectDemo() {
    final behavior = BehaviorSubject<int>();
    behavior.add(1);
    behavior.add(2);
    behavior.stream.listen((_count) {
      print("BehaviorSubject:" + _count.toString());
    });
    behavior.add(3);
    behavior.close();
  }

  void _rxDartDemo() {
    // 1,2,3,4 doOnData
    // 3,4,5,6 map
    // 5,6     where
    // 100,5,6 mergeWith
    Observable.range(1, 4)
        .map((val) => val + 2)
        .where((val) => val > 4)
        .distinct()
        .mergeWith([Observable.just(100)])
        .doOnData((_) => print('next data'))
        .doOnDone(() => print("all done--完成！"))
        .listen((val) => print('Observable收到数据:' + val.toString()));
  }
}
