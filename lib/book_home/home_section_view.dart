import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

class HomeSectionView extends StatelessWidget {
  final String title;

  HomeSectionView(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 4,
            height: 15,
            color: TYColor.primary,
          ),
          SizedBox(width: 10),
          Text(
            '$title',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
