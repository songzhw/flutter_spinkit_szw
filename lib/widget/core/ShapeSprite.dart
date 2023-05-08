import 'package:flutter/material.dart';
import 'package:flutter_spinkit_szw/widget/core/Sprite.dart';
import 'package:get/get.dart';

abstract class ShapeSprite extends Sprite {
  final brush = Paint()
    ..color = Colors.white;
  final double delayInSecond;
  ShapeSprite(this.delayInSecond);


  void drawShape(Canvas canvas, Rect rect, Paint brush); //抽象方法

  @override void drawSelf(Canvas canvas, Rect rect) {
    drawShape(canvas, rect, brush);
  }

  @override
  void startAnimation() {
    if(delayInSecond > 0) {
      delayInSecond.delay(()=> ctrl?.repeat());
    } else {
      super.startAnimation();
    }
  }
}

/*
1. Flutter中的Paint, 并没有setAlpha()方法哦
要改变alpha, 就得用: `paint.color = Color.white.withOpacity(double opacity)`
 */