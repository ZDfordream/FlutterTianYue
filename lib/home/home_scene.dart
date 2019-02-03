import 'package:flutter/material.dart';

import 'package:tianyue/public.dart';

import 'home_list_view.dart';

class HomeScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeSceneState();
}

class HomeSceneState extends State<HomeScene> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TabBar(
              labelColor: TYColor.darkGray,
              labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: TYColor.gray,
              indicatorColor: TYColor.secondary,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 3,
              indicatorPadding: EdgeInsets.fromLTRB(8, 0, 8, 5),
              tabs: [
                Tab(text: '精选'),
                Tab(text: '女生'),
                Tab(text: '男生'),
                Tab(text: '漫画'),
              ],
            ),
          ),
          backgroundColor: TYColor.white,
          elevation: 0,
        ),
        body: TabBarView(children: [
          HomeListView(HomeListType.excellent),
          HomeListView(HomeListType.female),
          HomeListView(HomeListType.male),
          HomeListView(HomeListType.cartoon),
        ]),
      ),
    );
  }
}
