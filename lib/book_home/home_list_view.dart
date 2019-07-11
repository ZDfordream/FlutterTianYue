import 'package:flutter/material.dart';
import 'package:tianyue/public.dart';

import 'home_banner.dart';
import 'home_model.dart';
import 'novel_first_hybird_card.dart';
import 'novel_four_grid_view.dart';
import 'novel_normal_card.dart';
import 'novel_second_hybird_card.dart';

enum HomeListType {
  excellent,
  male,
  female,
  cartoon,
}

class HomeListView extends StatefulWidget {
  final HomeListType type;

  HomeListView(this.type);

  @override
  State<StatefulWidget> createState() {
    return HomeListViewState();
  }
}

class HomeListViewState extends State<HomeListView>
    with AutomaticKeepAliveClientMixin {
  List<CarouselInfo> carouselInfos = [];
  int pageIndex = 1;
  List<HomeModule> modules = [];
  List<String> urls = [
    "https://manhua.qpic.cn/operation/0/19_23_51_3fa71e4fd07f0f370af0465faa6ccdb5_1555689063579.jpg/0",
    "https://manhua.qpic.cn/operation/0/19_23_51_898a3baa00cba550d9fe64a372bee24a_1555689101098.jpg/0",
    "https://manhua.qpic.cn/operation/0/19_23_52_6234abed1062e3601cd639fd376760a3_1555689133306.jpg/0",
    "https://manhua.qpic.cn/operation/0/19_23_52_c0343c40a42861d776eb2b265015bef2_1555689169278.jpg/0",
    "https://manhua.qpic.cn/operation/0/19_23_53_8968d75fb1619aa30adfaf271a271642_1555689199834.jpg/0"
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> fetchData() async {
    try {
      var action;
      switch (this.widget.type) {
        case HomeListType.excellent:
          action = 'home_excellent';
          break;
        case HomeListType.female:
          action = 'home_female';
          break;
        case HomeListType.male:
          action = 'home_male';
          break;
        case HomeListType.cartoon:
          action = 'home_cartoon';
          break;
        default:
          break;
      }
      var responseJson = await Request.get(url: action);
      List moduleData = responseJson['module'];
      List<HomeModule> modules = [];
      moduleData.forEach((data) {
        modules.add(HomeModule.fromJson(data));
      });

      setState(() {
        this.modules = modules;
        this.carouselInfos = carouselInfos;
      });
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  Widget bookCardWithInfo(HomeModule module) {
    Widget card;
    switch (module.style) {
      case 1:
        card = NovelFourGridView(module);
        break;
      case 2:
        card = NovelSecondHybirdCard(module);
        break;
      case 3:
        card = NovelFirstHybirdCard(module);
        break;
      case 4:
        card = NovelNormalCard(module);
        break;
    }
    return card;
  }

  Widget buildModule(BuildContext context, HomeModule module) {
    if (module.carousels != null) {
      return HomeBanner(urls);
    } else if (module.books != null) {
      return bookCardWithInfo(module);
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RefreshIndicator(
        onRefresh: fetchData,
        color: TYColor.primary,
        child: ListView.builder(
          itemCount: modules.length,
          itemBuilder: (BuildContext context, int index) {
            return buildModule(context, modules[index]);
          },
        ),
      ),
    );
  }
}
