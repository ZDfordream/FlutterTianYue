import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import 'package:tianyue/widget/loading_indicator.dart';

class WebScene extends StatefulWidget {
  final String url;
  final String title;

  WebScene({@required this.url, this.title});

  @override
  _WebSceneState createState() => _WebSceneState();
}

class _WebSceneState extends State<WebScene> {
  bool isDataReady = false;
  PageState pageState = PageState.Loading;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    await Future.delayed(Duration(milliseconds: 2000), () {
      pageState = PageState.Content;
    });

    setState(() {
      isDataReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isDataReady) {
      return LoadingIndicator(
        pageState,
      );
    }

    return WebviewScaffold(
      url: this.widget.url,
      appBar: AppBar(
        title: Text(this.widget.title ?? '腾讯动漫'),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              Share.share('https://github.com/ZDfordream/FlutterTianYue');
            },
            child: Image.asset('img/icon_menu_share.png'),
          ),
        ],
      ),
    );
  }
}
