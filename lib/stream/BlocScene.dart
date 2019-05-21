import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/stream/BlocProvider.dart';
import 'package:tianyue/stream/CounterWidget.dart';
import 'package:tianyue/stream/CounterStream.dart';
import 'package:tianyue/stream/IncrementBloc.dart';
import 'package:tianyue/widget/loading_indicator.dart';

class BlocScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Bloc"),
          elevation: 0,
        ),
        body: BlocProvider<IncrementBloc>(
          bloc: IncrementBloc(),
          child: CounterWidget(),
        ));
  }
}
