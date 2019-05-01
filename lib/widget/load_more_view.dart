import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class LoadMoreView extends StatefulWidget {
  final String loadString;

  LoadMoreView(this.loadString);

  @override
  LoadMoreViewState createState() => LoadMoreViewState();
}

class LoadMoreViewState extends State<LoadMoreView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.loadString,
          style: TextStyle(
              color: TYColor.darkGray,
              fontSize: 16,
              decoration: TextDecoration.none)),
      width: Screen.width,
      height: 40,
      alignment: Alignment.center,
    );
  }
}
