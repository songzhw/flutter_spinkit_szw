import 'package:flutter/material.dart';
import 'package:flutter_spinkit_szw/widget/core/ShapeSprite.dart';
import 'package:flutter_spinkit_szw/widget/core/Sprite.dart';
import 'package:flutter_spinkit_szw/widget/core/SpriteGroup.dart';
import 'package:flutter_spinkit_szw/widget/ext/CanvasTransformExt.dart';
import 'package:flutter_spinkit_szw/widget/utils/SpriteKeyFrameAnimationBuilder.dart';
import 'package:get/get.dart';

/*
坐标信息
x (2x) x (2x) x (2x) x
x表示空隙; (2x)表示一个圆, 半径为x, 所以直接为2x
这样就是 10x = width, 也就是为何radius = rect.width/10的原因了.
 */
class TripleBounceSprite extends SpriteGroup {
  @override
  List<Sprite> createChildren() => <Bounce3>[
      Bounce3(0),Bounce3(0.16),Bounce3(0.32),
    ];

  // 重写这个, 主要就是要限制child的范围. 类似指定Android中child drawable的drawBounds一样
  @override
  void drawSelf(Canvas canvas, Rect rect) {
    final radius = rect.width / 10.0;
    final dy = rect.center.dy;
    for (int i = 0; i < sprites.length; i++) {
      final dx = (i * 3 + 2) * radius;
      final childCenter = Offset(dx, dy);
      final childRect = Rect.fromCircle(center: childCenter, radius: radius);
      sprites[i].drawSelf(canvas, childRect);
    }
  }
}

class Bounce3 extends ShapeSprite {
  Bounce3(double delay): super(delay);

  @override
  void createAnimation() {
    ctrl = AnimationController(duration: 1.4.seconds, vsync: ticker);
    final fractions = <double>[0, 0.4, 0.8, 1];
    anim = SpriteKeyFrameAnimationBuilder()
        .scale(fractions, <double>[0, 1, 0, 0])
        .build(ctrl!);
  }

  @override
  void drawShape(Canvas canvas, Rect rect, Paint brush) {
    final radius = rect.width / 2.2;
    final scale = anim.value<double>("scale");
    canvas.scaleAndDraw(sx: scale, sy: scale, pivot: rect.center, drawFunction: () {
      canvas.drawCircle(rect.center, radius, brush);
    });
  }

}
