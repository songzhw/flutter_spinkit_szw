import 'package:flutter/material.dart';
import 'package:flutter_spinkit_szw/widget/core/ShapeSprite.dart';
import 'package:flutter_spinkit_szw/widget/core/Sprite.dart';
import 'package:flutter_spinkit_szw/widget/core/SpriteGroup.dart';
import 'package:flutter_spinkit_szw/widget/ext/CanvasTransformExt.dart';
import 'package:flutter_spinkit_szw/widget/utils/SpriteKeyFrameAnimationBuilder.dart';
import 'package:get/get.dart';

class ScaleBeadsSprite extends SpriteGroup {
  @override
  List<Sprite> createChildren() => List.generate(12, (index) => ScaleBead(index * 0.1));

  @override
  void drawSelf(Canvas canvas, Rect rect) {
    // 得出child要在哪里绘画 (其实就是上方正中间)
    final childSize = sprites.length;
    final beadRadius = rect.width / childSize * 0.65;
    final childCenter = Offset(rect.center.dx, rect.top + 3.5 * beadRadius);
    final childRect = Rect.fromCircle(center: childCenter, radius: beadRadius);

    // dispatch drawing (当然自己也要旋转)
    for (int i = 0; i < childSize; i++) {
      canvas.save();
      canvas.rotateWithPivot(pivot: rect.center, degree: i * 360.0 / childSize);
      sprites[i].drawSelf(canvas, childRect);
      canvas.restore();
    }
  }
}

class ScaleBead extends ShapeSprite {
  ScaleBead(super.delayInSecond);

  @override
  void createAnimation() {
    ctrl = AnimationController(duration: 1.2.seconds, vsync: ticker);
    anim = SpriteKeyFrameAnimationBuilder()
        .scale([0, 0.5, 1], [0, 1, 0])
        .build(ctrl!);
  }

  @override
  void drawShape(Canvas canvas, Rect rect, Paint brush) {
    final scale = anim.value<double>("scale");
    canvas.scaleAndDraw(sx: scale, sy: scale, pivot: rect.center, drawFunction: () {
      canvas.drawCircle(rect.center, rect.width / 2.0, brush);
    });
  }
}
