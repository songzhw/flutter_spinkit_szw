import 'dart:math';

import 'package:flutter/material.dart';

extension ScaleWithPivot on Canvas {
  void scaleWithPivot({required double sx, required double sy, required Offset pivot}) {
    this.translate(pivot.dx, pivot.dy);
    this.scale(sx, sy);
    this.translate(-pivot.dx, -pivot.dy);
  }

  void scaleAndDraw({required double sx, required double sy, required Offset pivot, required VoidCallback drawFunction}) {
    this.save();
    this.scaleWithPivot(sx: sx, sy: sy, pivot: pivot);
    drawFunction();
    this.restore();
  }
}

extension RotationWithPivot on Canvas {
  void rotateWithPivot({required Offset pivot, required double degree}) {
    this.translate(pivot.dx, pivot.dy);
    this.rotate(degree * pi / 180.0);
    this.translate(-pivot.dx, -pivot.dy);
  }

  void rotateAndDraw(Offset pivot, double degree, VoidCallback drawFunction) {
    this.save();
    this.rotateWithPivot(pivot: pivot, degree: degree);
    drawFunction();
    this.restore();
  }
}
