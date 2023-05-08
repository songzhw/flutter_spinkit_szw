import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation.dart';
import 'package:flutter_spinkit_szw/widget/core/ShapeSprite.dart';
import 'package:flutter_spinkit_szw/widget/core/Sprite.dart';
import 'package:flutter_spinkit_szw/widget/core/SpriteGroup.dart';
import 'package:flutter_spinkit_szw/widget/ext/CanvasTransformExt.dart';
import 'package:flutter_spinkit_szw/widget/utils/SpriteKeyFrameAnimationBuilder.dart';
import 'package:get/get.dart';
import 'package:keyframes_tween/src/compound_value.dart';

class DoubleBounceSprite extends SpriteGroup {
  @override List<Sprite> createChildren() => <Bounce2>[Bounce2(0), Bounce2(1.0)];
}


class Bounce2 extends ShapeSprite {
  Bounce2(double delay): super(delay);

  @override
  void createAnimation() {
    ctrl = AnimationController(duration: 2.0.seconds, vsync: ticker);
    final fractions = <double>[0, 0.5, 1];
    anim = SpriteKeyFrameAnimationBuilder()
        .scale(fractions, <double>[0, 1, 0])
        .build(ctrl!);
  }

  @override
  void drawShape(Canvas canvas, Rect rect, Paint brush) {
    brush.color = Colors.white.withOpacity(0.5);
    final scale = anim.value<double>("scale");
    canvas.scaleAndDraw(sx: scale, sy: scale, pivot: rect.center, drawFunction: () {
      canvas.drawCircle(rect.center, rect.width / 2.5, brush);
    });
  }

}