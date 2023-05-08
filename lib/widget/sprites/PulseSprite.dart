import 'package:flutter/material.dart';
import 'package:flutter_spinkit_szw/widget/core/ShapeSprite.dart';
import 'package:flutter_spinkit_szw/widget/ext/CanvasTransformExt.dart';
import 'package:flutter_spinkit_szw/widget/utils/SpriteKeyFrameAnimationBuilder.dart';
import 'package:get/get.dart';
import 'package:keyframes_tween/src/compound_value.dart';

class PulseSprite extends ShapeSprite {
  PulseSprite(): super(0);

  @override
  void createAnimation() {
    ctrl = AnimationController(duration: 1.0.seconds, vsync: ticker);
    final fractions = <double>[0, 1];
    anim = SpriteKeyFrameAnimationBuilder()
      .scale(fractions, <double>[0, 1])
      .opacity(fractions, <double>[1, 0])
      .build(ctrl!);
  }

  @override
  void drawShape(Canvas canvas, Rect rect, Paint brush) {
    final scale = anim.value<double>("scale");
    final opacity = anim.value<double>("opacity");
    brush.color = Colors.white.withOpacity(opacity);

    // canvas.scale(scale, scale); //这个不行, 会让scale的pivot是左上角
    canvas.scaleWithPivot(sx: scale, sy: scale, pivot:rect.center); //这种scale才是在中间开始scale
    canvas.drawCircle(rect.center, rect.width / 2.5, brush);
  }

}
