import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter_spinkit_szw/widget/core/Sprite.dart';

abstract class SpriteGroup extends Sprite {
  List<Sprite> sprites = [];

  @override void init(TickerProvider tick) {
    super.init(tick); //若没这句, 像ChasingDots这样有动画的group, 就会报错说ticker has not been initialized
    sprites = createChildren();
    for(final sprite in sprites ) {
      sprite.init(tick);
      sprite.createAnimation();
    }
  }

  // = = = = = = = = = = = = abstract methods = = = = = = = = = = = =
  List<Sprite> createChildren();

  // = = = = = = = = = = = = override methods = = = = = = = = = = = =

  @override
  void drawSelf(Canvas canvas, Rect rect) {
    for (final sprite in sprites) {
      sprite.drawSelf(canvas, rect);
    }
  }

  // 加个默认实现, 免得所有没有动画的子类也要写这个
  // 目前只有ChasingDotsSprite这个子类需要动画, 那就可以重写这个函数
  @override void createAnimation() { }

  @override
  void startAnimation() {
    ctrl?.repeat();
    for (final sprite in sprites) {
      sprite.startAnimation();
    }
  }

  @override
  void stopAnimation() {
    ctrl?.dispose();
    for (final sprite in sprites) {
      sprite.stopAnimation();
    }
  }
}
