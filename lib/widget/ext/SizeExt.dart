import 'package:flutter/material.dart';

extension SizeExt on Size {
  double centerY() {
    return this.center(Offset.zero).dy;
  }

  double centerX() {
    return this.center(Offset.zero).dx;
  }


}