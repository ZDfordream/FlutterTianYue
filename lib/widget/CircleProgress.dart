import 'dart:math';

import 'package:flutter/material.dart';

class CircleProgress extends StatelessWidget {
  CircleProgress(
      {this.stokeWidth = 2.0,
      @required this.radius,
      @required this.colors,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.totalAngle = 2 * pi,
      this.value});

  ///粗细
  final double stokeWidth;

  /// 圆的半径
  final double radius;

  /// 当前进度，取值范围 [0.0-1.0]
  final double value;

  /// 进度条背景色
  final Color backgroundColor;

  /// 进度条的总弧度，2*PI为整圆，小于2*PI则不是整圆
  final double totalAngle;

  /// 渐变色数组
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 2.0,
      child: CustomPaint(
          size: Size.fromRadius(radius),
          painter: _CircleProgressPainter(
            stokeWidth: stokeWidth,
            backgroundColor: backgroundColor,
            value: value,
            total: totalAngle,
            radius: radius,
            colors: colors,
          )),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  _CircleProgressPainter(
      {this.stokeWidth: 10.0,
      this.backgroundColor = const Color(0xFFEEEEEE),
      this.radius,
      this.total = 2 * pi,
      @required this.colors,
      this.stops,
      this.value});

  final double stokeWidth;
  final double value;
  final Color backgroundColor;
  final List<Color> colors;
  final double total;
  final double radius;
  final List<double> stops;

  @override
  void paint(Canvas canvas, Size size) {
    double x = size.width / 2;
    double y = size.height / 2;
    Offset center = new Offset(x, y);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeWidth = stokeWidth;
    // 背景圆
    if (backgroundColor != Colors.transparent) {
      paint.color = backgroundColor;
      canvas.drawCircle(center, radius, paint);
    }
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    double startAngle = 0;
    double sweepAngle = 2 * pi * value;

    // 渐变圆弧
    if (value > 0) {
      paint.shader = SweepGradient(
        startAngle: startAngle,
        endAngle: sweepAngle,
        colors: colors,
      ).createShader(rect);
      canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
