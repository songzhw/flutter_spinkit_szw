
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:keyframes_tween/keyframes_tween.dart';

class SpriteKeyFrameAnimationBuilder {
  final Curve curve;
  List<KeyframeProperty> properties = [];

  SpriteKeyFrameAnimationBuilder({this.curve = Curves.easeInOut});

  // = = = = = = = = = = = = = builder = = = = = = = = = = = = =
  Animation<KeyframeValue> build(AnimationController ctrl) {
    final tween = KeyframesTween(properties);
    return tween.animate(ctrl);
  }

  // = = = = = = = = = = = = =  property keyframe change = = = = = = = = = = = = =
  SpriteKeyFrameAnimationBuilder opacity(List<double> fractions, List<double> values) {
    return _configDoubleProperty("opacity", fractions, values);
  }

  SpriteKeyFrameAnimationBuilder scale(List<double> fractions, List<double> values) {
    return _configDoubleProperty("scale", fractions, values);
  }

  SpriteKeyFrameAnimationBuilder scaleY(List<double> fractions, List<double> values) {
    return _configDoubleProperty("scaleY", fractions, values);
  }

  SpriteKeyFrameAnimationBuilder rotateX(List<double> fractions, List<double> values) {
    return _configDoubleProperty("rotateX", fractions, values);
  }

  SpriteKeyFrameAnimationBuilder rotateY(List<double> fractions, List<double> values) {
    return _configDoubleProperty("rotateY", fractions, values);
  }

  SpriteKeyFrameAnimationBuilder rotateZ(List<double> fractions, List<double> values) {
    return _configDoubleProperty("rotateZ", fractions, values);
  }

  // = = = = = = = = = = = = =  private functions = = = = = = = = = = = = =
  void _ensurePairSizeEqual(List fractions, List values) {
    if (fractions.length != values.length) {
      throw Exception(
          "the fractions(size = ${fractions.length}) and values(size = ${values.length}) must have a same size");
    }
  }

  SpriteKeyFrameAnimationBuilder _configDoubleProperty(String name, List<double> fractions, List<double> values){
    _ensurePairSizeEqual(fractions, values);
    List<Keyframe<double>> keyframeList = [];
    for (var i = 0; i < fractions.length; i++) {
      keyframeList.add(values[i].keyframe(fractions[i], this.curve));
    }
    KeyframeProperty<double> prop = KeyframeProperty(keyframeList, name: name);
    properties.add(prop);
    return this;
  }


}