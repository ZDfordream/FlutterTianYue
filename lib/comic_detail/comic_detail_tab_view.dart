import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class ComicDetailTabView extends StatelessWidget {
  final String text;
  final int index;
  final int currentItem;
  final OnTabClickListener clickListener;

  ComicDetailTabView(
      this.text, this.index, this.currentItem, this.clickListener);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.clickListener.onTabClick(this.index),
      child: Container(
        height: 43,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(this.text,
                style: TextStyle(
                    fontSize: 15,
                    color: this.currentItem == this.index
                        ? TYColor.darkGray
                        : TYColor.gray,
                    decoration: TextDecoration.none)),
            Container(
                margin: EdgeInsets.symmetric(horizontal:40),
                width: 10,
                height: 3,
                color: this.currentItem == this.index
                    ? TYColor.primary
                    : TYColor.white)
          ],
        ),
        alignment: Alignment.center,
      ),
    );
  }
}

abstract class OnTabClickListener {
  onTabClick(int index);
}
