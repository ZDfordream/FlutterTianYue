import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/comic_home/comic_block_item_view.dart';
import 'package:tianyue/comic_home/comic_block_header_view.dart';

class ComicBlockView extends StatelessWidget {
  final List<ComicBlock> blockList;

  ComicBlockView(this.blockList);

  @override
  Widget build(BuildContext context) {
    if (blockList == null || blockList.length == 0) {
      return Container();
    }
    var children = blockList
        .map((comicItem) => ComicBlockItemView(comicItem, TYColor.white))
        .toList();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 5),
          ComicBlockHeaderView(Constant.comicBlock),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            child: Wrap(spacing: 15, runSpacing: 15, children: children),
          ),
        ],
      ),
    );
  }
}
