import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tianyue/me/ScrollDemoScene.dart';
import 'package:tianyue/me/map_scene.dart';
import 'package:tianyue/public.dart';

import 'me_cell.dart';
import 'me_header.dart';
import 'setting_scene.dart';

class MeScene extends StatelessWidget {

  Widget buildCells(BuildContext context) {
    Screen.updateStatusBarStyle(SystemUiOverlayStyle.dark);
    return Container(
      child: Column(
        children: <Widget>[
          MeCell(
            title: '钱包',
            iconName: 'img/me_wallet.png',
            onPressed: () {
            },
          ),
          MeCell(
            title: '消费充值记录',
            iconName: 'img/me_record.png',
            onPressed: () {},
          ),
          MeCell(
            title: '购买的书',
            iconName: 'img/me_buy.png',
            onPressed: () {},
          ),
          MeCell(
            title: '我的会员',
            iconName: 'img/me_vip.png',
            onPressed: () {},
          ),
          MeCell(
            title: '绑兑换码',
            iconName: 'img/me_coupon.png',
            onPressed: () {},
          ),
          MeCell(
            title: '公益行动',
            iconName: 'img/me_action.png',
            onPressed: () {},
          ),
          MeCell(
            title: '我的收藏',
            iconName: 'img/me_favorite.png',
            onPressed: () {},
          ),
          MeCell(
            title: '个性换肤',
            iconName: 'img/me_theme.png',
            onPressed: () {},
          ),
          MeCell(
            title: '加载更多示例',
            iconName: 'img/me_record.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ScrollDemoScene();
              }));
            },
          ),
          MeCell(
            title: '地图',
            iconName: 'img/me_date.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MapScene();
              }));
            },
          ),
          MeCell(
            title: '关于',
            iconName: 'img/me_comment.png',
            onPressed: () {
              FlutterBridge.goAboutActivity();
            },
          ),
          MeCell(
            title: '电量',
            iconName: 'img/reader_battery.png',
            onPressed: () {
              FlutterBridge.getBatteryLevel();
            },
          ),
          MeCell(
            title: '设置',
            iconName: 'img/me_setting.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SettingScene();
              }));
            },
          ),
          MeCell(
            title: '网页',
            iconName: 'img/me_feedback.png',
            onPressed: () {
              AppNavigator.pushWeb(
                  context, 'https://www.baidu.com', '百度');
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: Container(color: TYColor.white),
        preferredSize: Size(Screen.width, 0),
      ),
      body: Container(
        color: Colors.white,
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            MeHeader(),
            SizedBox(height: 10),
            buildCells(context),
          ],
        ),
      ),
    );
  }
}
