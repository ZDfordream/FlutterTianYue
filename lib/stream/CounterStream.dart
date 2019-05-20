import 'dart:async';

import 'package:tianyue/stream/stream_base.dart';

class CounterStream extends StreamBase {
  var _controller = StreamController<int>();

  get _sink => _controller.sink;

  get streamOut => _controller.stream;

  void increment(int count) {
    _sink.add(++count);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
