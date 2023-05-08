import 'package:flutter/material.dart';
import 'package:keyframes_tween/keyframes_tween.dart';

abstract class Sprite {
  late TickerProvider ticker;

  AnimationController? ctrl; //一些SpriteGroup可能自己没动画, 所以它们自己的ctrl为空
  late Animation<KeyframeValue> anim;

  // = = = = = = = = = = = = abstract methods = = = = = = = = = = = =
  // dart中的抽象方法不带abstract关键字而已
  void drawSelf(Canvas canvas, Rect rect);
  void createAnimation();

  // = = = = = = = = = = = = others = = = = = = = = = = = =
  void init(TickerProvider ticker) {
    this.ticker = ticker;
  }

  void startAnimation() {
    ctrl?.repeat();
  }

  void stopAnimation() {
    ctrl?.dispose();
  }

}