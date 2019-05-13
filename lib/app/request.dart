import 'dart:io';
import 'package:dio/dio.dart';

import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class Request {
  static const String baseUrl = 'http://192.168.4.32/';

  static Future<dynamic> get({String action, Map params}) async {
    return Request.mock(action: action, params: params);
  }

  static Future<dynamic> getByHttpClient({String url, Map params}) async {
    // 实例化
    HttpClient httpClient = new HttpClient();
    // 打开Http连接
    HttpClientRequest request = await httpClient.get(
        "192.168.4.32", 8080, "/get_home_page/section_data");
    // 请求头
    request.headers.add("user-agent", "test");
    // 等待连接服务器
    var response = await request.close();
    // 获取响应内容
    String responseBody = await response.transform(utf8.decoder).join();
    //关闭httpClient
    httpClient.close();
    return json.decode(responseBody);
  }

  static Future<dynamic> getByDio({String url, Map params}) async {
    var dio = Request.createDio();
    Response<Map> response =
        await dio.get("/get_home_page/section_data");
    var data = response.data;
    return data;
  }

  static Future<dynamic> post({String action, Map params}) async {
    return Request.mock(action: action, params: params);
  }

  static Future<dynamic> mock({String action, Map params}) async {
    var responseStr = await rootBundle.loadString('mock/$action.json');
    var responseJson = json.decode(responseStr);
    return responseJson['data'];
  }

  static Dio createDio() {
    var options = Options(
      baseUrl: "http://192.168.4.32:8080",
      connectTimeout: 10000,
      receiveTimeout: 10000,
      contentType: ContentType.json,
    );
    return Dio(options);
  }
}
