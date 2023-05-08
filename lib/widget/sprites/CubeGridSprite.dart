import 'package:flutter/material.dart';
import 'package:flutter_spinkit_szw/widget/core/ShapeSprite.dart';
import 'package:flutter_spinkit_szw/widget/core/Sprite.dart';
import 'package:flutter_spinkit_szw/widget/core/SpriteGroup.dart';
import 'package:flutter_spinkit_szw/widget/ext/CanvasTransformExt.dart';
import 'package:get/get.dart';

import '../utils/SpriteKeyFrameAnimationBuilder.dart';

class CubeGridSprite extends SpriteGroup {
  // 总长1300ms, 其中左下角cube(无delay)的做35%的时间, 这就是455ms. 正好轮到最右上角的cube开始做动画
  final delays = <double>[
    0.2,    0.3,    0.4,
    0.1,    0.2,    0.3,
    0.0,    0.1,    0.2,
  ]; // 这个delay的形式, 正是动画的展现方式, 即斜着的一串是一样的动画delay

  @override
  List<Sprite> createChildren() => List.generate(delays.length, (index) => CubeInGrid(delays[index]));

  @override
  void drawSelf(Canvas canvas, Rect rect) {
    final cubeSize = rect.width / 6.0;
    for (int i = 0; i < delays.length; i++) {
      int column = i % 3;
      int row = i ~/ 3;
      final childCenter = Offset(cubeSize * (2 * column + 1), cubeSize * (2 * row + 1));
      final childRect = Rect.fromCircle(center: childCenter, radius: cubeSize);
      sprites[i].drawSelf(canvas, childRect);
    }
  }
}

class CubeInGrid extends ShapeSprite {
  CubeInGrid(super.delayInSecond);

  @override
  void createAnimation() {
    ctrl = AnimationController(duration: 1.3.seconds, vsync: ticker);
    anim = SpriteKeyFrameAnimationBuilder()
        .scale([0, 0.35, 0.7, 1], [1, 0, 1, 1])
        .build(ctrl!);
  }

  @override
  void drawShape(Canvas canvas, Rect rect, Paint brush) {
    final scale = anim.value<double>("scale");
    canvas.scaleAndDraw( sx: scale, sy: scale, pivot: rect.center, drawFunction: () {
      canvas.drawRect(rect, brush);
    });
  }
}
