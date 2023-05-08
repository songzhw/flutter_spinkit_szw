import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit_szw/widget/core/ShapeSprite.dart';
import 'package:flutter_spinkit_szw/widget/core/Sprite.dart';
import 'package:flutter_spinkit_szw/widget/core/SpriteGroup.dart';
import 'package:flutter_spinkit_szw/widget/ext/CanvasTransformExt.dart';
import 'package:flutter_spinkit_szw/widget/utils/SpriteKeyFrameAnimationBuilder.dart';
import 'package:get/get.dart';

class ChasingDotsSprite extends SpriteGroup {

  @override
  List<Sprite> createChildren() => <Sprite>[ChasingDot(0), ChasingDot(1.0)];

  @override
  void createAnimation() {
    ctrl = AnimationController(duration: 2.0.seconds, vsync: ticker);
    anim = SpriteKeyFrameAnimationBuilder(curve: Curves.linear)
        .rotateZ([0, 1], [0, 360])
        .build(ctrl!);
  }

  @override
  void drawSelf(Canvas canvas, Rect rect) {
    final childSize = rect.width * 0.6;
    final rightTopRect = Rect.fromLTWH(rect.right - childSize, rect.top, childSize, childSize);
    final rightBottomRect = Rect.fromLTWH(rect.right - childSize, rect.bottom - childSize, childSize, childSize);
    final rotateZ = anim.value<double>("rotateZ");
    canvas.rotateWithPivot(pivot: rect.center, degree: rotateZ);
    sprites[0].drawSelf(canvas, rightTopRect);
    sprites[1].drawSelf(canvas, rightBottomRect);
  }

}

class ChasingDot extends ShapeSprite {
  ChasingDot(super.delayInSecond);

  @override
  void createAnimation() {
    ctrl = AnimationController(duration: 2.0.seconds, vsync: ticker);
    anim = SpriteKeyFrameAnimationBuilder()
        .scale([0, 0.5, 1], [0, 1, 0])
        .build(ctrl!);
  }

  @override
  void drawShape(Canvas canvas, Rect rect, Paint brush) {
    final radius = rect.width / 3.5;
    final scale = anim.value<double>("scale");
    canvas.scaleAndDraw(sx: scale, sy: scale, pivot: rect.center, drawFunction: () {
      canvas.drawCircle(rect.center, radius, brush);
    });
  }


}