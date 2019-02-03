# 天阅Flutter

## screen shot

<img src="screenshot/android_0.png">

<img src="screenshot/android_1.png">

<img src="screenshot/android_2.png">

## Setup

1. Clone the repo

2. flutter run

## Dependency

* [carousel_slider](https://pub.flutter-io.cn/packages/carousel_slider)
* [cached_network_image](https://pub.flutter-io.cn/packages/cached_network_image)
* [shared_preferences](https://pub.flutter-io.cn/packages/shared_preferences)
* [flutter_webview_plugin](https://pub.flutter-io.cn/packages/flutter_webview_plugin)
* [share](https://pub.flutter-io.cn/packages/share)

## 简介

这是一个用Flutter写的阅读类app。

我试着让这个Demo的结构尽量接近实际项目，同时使用比较简单方式去实现功能。这样可以让刚接触Flutter的人更够容易理解代码。

App中的网络请求均通过一个名为**Request**的工具类。在Request内部，通过**本地mock**方式，获取模拟数据。