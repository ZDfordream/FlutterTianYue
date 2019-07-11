import 'package:flutter/material.dart';
import 'dart:async';

import 'package:tianyue/public.dart';

import 'code_button.dart';

class LoginScene extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginSceneState();
}

class LoginSceneState extends State {
  TextEditingController phoneEditor = TextEditingController();
  TextEditingController codeEditor = TextEditingController();
  int coldDownSeconds = 0;
  Timer timer;

  fetchSmsCode() async {
    if (phoneEditor.text.length == 0) {
      return;
    }
    try {
      await Request.post(
        url: 'sms',
        params: {'phone': phoneEditor.text, 'type': 'login'},
      );
      setState(() {
        coldDownSeconds = 60;
      });
      coldDown();
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  login() async {
    var phone = phoneEditor.text;
    var code = codeEditor.text;

    try {
      var response = await Request.post(url: 'login', params: {
        'phone': phone,
        'code': code,
      });
      UserManager.instance.login(response);

      Navigator.pop(context);
    } catch (e) {
      Toast.show(e.toString());
    }
  }

  @override
  void dispose() {
    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  coldDown() {
    timer = Timer(Duration(seconds: 1), () {
      setState(() {
        --coldDownSeconds;
      });

      coldDown();
    });
  }

  Widget buildPhone() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: TYColor.paper,
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        controller: phoneEditor,
        keyboardType: TextInputType.phone,
        style: TextStyle(fontSize: 14, color: TYColor.darkGray),
        decoration: InputDecoration(
          hintText: '请输入手机号',
          hintStyle: TextStyle(color: TYColor.gray),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget buildCode() {
    return Container(
      padding: EdgeInsets.only(left: 8),
      decoration: BoxDecoration(
        color: TYColor.paper,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: codeEditor,
              keyboardType: TextInputType.phone,
              style: TextStyle(fontSize: 14, color: TYColor.darkGray),
              decoration: InputDecoration(
                hintText: '请输入短信验证码',
                hintStyle: TextStyle(color: TYColor.gray),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(color: Color(0xffdae3f2), width: 1, height: 40),
          CodeButton(
            onPressed: fetchSmsCode,
            coldDownSeconds: coldDownSeconds,
          ),
        ],
      ),
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildPhone(),
              SizedBox(height: 10),
              buildCode(),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: TYColor.primary,
                ),
                height: 40,
                child: FlatButton(
                  onPressed: login,
                  child: Text(
                    '登录',
                    style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('登录'), elevation: 0),
      backgroundColor: Colors.white,
      body: buildBody(),
    );
  }
}
