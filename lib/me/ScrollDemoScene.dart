import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';
import 'package:tianyue/widget/load_more_view.dart';

class ScrollDemoScene extends StatefulWidget {
  @override
  _ScrollDemoSceneState createState() => _ScrollDemoSceneState();
}

class _ScrollDemoSceneState extends State<ScrollDemoScene> {
  List<int> items = List.generate(20, (i) => i);
  ScrollController _scrollController = new ScrollController();
  int _pageIndex = 1;
  String _loadString = "正在加载更多...";
  bool _hasMore;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  _getMoreData() async {
    _loadString = _pageIndex >= 3 ? "已加载到底部" : "正在加载更多...";
    _hasMore = _pageIndex >= 3 ? false : true;
    if (!_hasMore) {
      setState(() {});
      return;
    }
    List<int> newEntries =
        await fakeRequest(items.length, items.length + 10); //returns
    _pageIndex++;
    setState(() {
      items.addAll(newEntries);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    /// 初始状态归位
    _pageIndex = 1;
    _hasMore = true;
    _loadString = "正在加载更多...";

    await Future.delayed(Duration(seconds: 1), () {
      items = List.generate(20, (i) => i);
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('加载更多示例'), elevation: 0.5),
      body: Container(
          color: Colors.white,
          child: RefreshIndicator(
            onRefresh: fetchData,
            color: TYColor.primary,
            child: ListView.builder(
              itemCount: items.length + 1,
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return LoadMoreView(_loadString);
                } else {
                  return Container(
                    child: Text("Number $index",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffe86a3e),
                            decoration: TextDecoration.none)),
                    height: 40,
                    alignment: Alignment.center,
                  );
                }
              },
              controller: _scrollController,
            ),
          )),
    );
  }
}

Future<List<int>> fakeRequest(int from, int to) async {
  return Future.delayed(Duration(seconds: 2), () {
    return List.generate(to - from, (i) => i + from);
  });
}
