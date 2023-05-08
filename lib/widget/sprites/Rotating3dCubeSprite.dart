import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit_szw/widget/core/ShapeSprite.dart';
import 'package:flutter_spinkit_szw/widget/utils/SpriteKeyFrameAnimationBuilder.dart';
import 'package:get/get.dart';

class Rotating3dCubeSprite extends ShapeSprite {
  Rotating3dCubeSprite(super.delayInSecond);

  @override
  void createAnimation() {
    ctrl = AnimationController(duration: 1.5.seconds, vsync: ticker);
    final fractions = <double>[0, 0.5, 1];
    anim = SpriteKeyFrameAnimationBuilder()
        .rotateX(fractions, <double>[0, -180, -180])
        .rotateY(fractions, <double>[0,    0, -180])
        .build(ctrl!);
  }

  @override
  void drawShape(Canvas canvas, Rect rect, Paint brush) {
    final radius = rect.width / 4.0;
    final rx = anim.value<double>("rotateX");
    final ry = anim.value<double>("rotateY");
    final halfWidth = rect.width / 2.0;
    final halfHeight = rect.height / 2.0;

    final matrix = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..translate(halfWidth, halfHeight) //原pivot是rotate绕着topCenter, 现在要移到正中心
      ..rotateX(rx * pi / 180.0) //rotateX是上下flip,  rotateY是左右flip
      ..rotateY(ry * pi / 180.0) //rotateX是上下flip,  rotateY是左右flip
      ..translate(-halfWidth, -halfHeight); //原pivot是rotate绕着topCenter, 现在要移到正中心
    canvas.transform(matrix.storage);

    final drawRect = Rect.fromCircle(center: rect.center, radius: radius);
    canvas.drawRect(drawRect, brush);
  }

}