import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:tianyue/utility/tian_yue_cache_manager.dart';

class Request {
  static const String baseUrl = 'http://192.168.4.32/';

  static Future<dynamic> get({String url, Map params}) async {
    return Request.mock(url: url, params: params);
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
    Response<String> response = await dio.get("/get_home_page/section_data");
    var data = response.data;
    return json.decode(data);
  }

  static Future<dynamic> post({String url, Map params}) async {
    return Request.mock(url: url, params: params);
  }

  static Future<dynamic> mock({String url, Map params}) async {
    var responseStr = await rootBundle.loadString('mock/$url.json');
    var responseJson = json.decode(responseStr);
    return responseJson['data'];
  }

  static Dio createDio() {
    var options = BaseOptions(
      baseUrl: "http://192.168.43.131:8080",
      connectTimeout: 10000,
      receiveTimeout: 10000,
      contentType: ContentType.json,
    );
    var dio = Dio(options);
    dio.interceptors.add(CacheInterceptor(dio));
    return dio;
  }
}

class CacheInterceptor extends InterceptorsWrapper {

  Dio dio;

  CacheInterceptor(Dio dio){
    this.dio = dio;
  }
  
  @override
  onRequest(RequestOptions options) async {
    FileInfo info = await TianYueCacheManager().getFileFromCache(options.uri.toString());
    if (info != null) {
      print("使用缓存" + options.uri.toString());
      String data = await info.file.readAsString();
      return dio.resolve(data);
    }
    print("无缓存" + options.uri.toString());
    return options;
  }

  @override
  onResponse(Response response) async {
    // 这里服务器返回的不是String,而是map<String,dynamic>
    // 如果是string,则不需要如此转换
    //String body = json.encode(response.data);
    var data = response.data;
    await TianYueCacheManager().putStringFile(response.request.uri.toString(), data);
    print("网络数据：" + data);
    return response;
  }

  @override
  onError(DioError e) async {
    print('NetError: $e');
  }
}
