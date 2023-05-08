import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit_szw/widget/core/ShapeSprite.dart';
import 'package:flutter_spinkit_szw/widget/core/Sprite.dart';
import 'package:flutter_spinkit_szw/widget/core/SpriteGroup.dart';
import 'package:flutter_spinkit_szw/widget/ext/CanvasTransformExt.dart';
import 'package:flutter_spinkit_szw/widget/utils/SpriteKeyFrameAnimationBuilder.dart';
import 'package:get/get.dart';

/*
坐标信息
x (2x) x (2x) x (2x) x (2x) x (2x) x
x表示空隙; (2x)表示一个方块, 长度为2x
这样就是 16x = width, 也就是为何 unit = rect.width/16的原因了.
 */

class SoundWaveSprite extends SpriteGroup {
  @override
  List<Sprite> createChildren() => List.generate(5, (index) => SoundWaveItem(0.6 + 0.12 * index));

  // 确定child的绘画范围, 并通过 child.drawSelf()给传进去
  @override
  void drawSelf(Canvas canvas, Rect rect) {
    final xUnit = rect.width / 16.0;
    final height = 10 * xUnit;
    for (int i = 0; i < sprites.length; i++) {
      final childCenter = Offset( (2 + 3 * i) * xUnit, rect.center.dy);
      final childRect = Rect.fromCenter(center: childCenter, width: 2 * xUnit, height: height);
      sprites[i].drawSelf(canvas, childRect);
    }
  }
}

class SoundWaveItem extends ShapeSprite {
  SoundWaveItem(double delay) : super(delay);

  @override
  void createAnimation() {
    ctrl = AnimationController(duration: 1.4.seconds, vsync: ticker);
    final fractions = <double>[0, 0.25, 0.45, 1];
    anim = SpriteKeyFrameAnimationBuilder()
        .scaleY(fractions, <double>[0.4, 1, 0.4, 0.4])
        .build(ctrl!);
  }

  @override
  void drawShape(Canvas canvas, Rect rect, Paint brush) {
    final scaleY = anim.value<double>("scaleY");
    canvas.scaleAndDraw(sx: 1, sy: scaleY, pivot: rect.center, drawFunction: () {
      canvas.drawRect(rect, brush); //brush默认就是fill (并非stroke)
    });
  }
}
