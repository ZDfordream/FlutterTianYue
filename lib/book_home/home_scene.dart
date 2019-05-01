import 'package:flutter/material.dart';

import 'package:tianyue/public.dart';

import 'home_list_view.dart';

class HomeScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeSceneState();
}

class HomeSceneState extends State<HomeScene>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, initialIndex: 1, length: 3);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          brightness: Brightness.light,
          title: Container(
              height: 40,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TabBar(
                  tabs: [
                    Tab(text: '女生'),
                    Tab(text: '漫画'),
                    Tab(text: '男生'),
                  ],
                  controller: _tabController,
                  labelPadding: EdgeInsets.symmetric(horizontal: 25),
                  isScrollable: true,
                  indicatorColor: TYColor.primary,
                  labelColor: TYColor.primary,
                  labelStyle: TextStyle(
                      fontSize: 22,
                      color: TYColor.primary,
                      fontWeight: FontWeight.w500),
                  unselectedLabelColor: Colors.black,
                  unselectedLabelStyle:
                      TextStyle(fontSize: 16, color: Colors.black),
                  indicatorSize: TabBarIndicatorSize.label)),
          backgroundColor: TYColor.white,
          elevation: 0,
        ),
        body: TabBarView(
          children: [
            HomeListView(HomeListType.female),
            HomeListView(HomeListType.cartoon),
            HomeListView(HomeListType.male),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
