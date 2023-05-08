import 'package:flutter/material.dart';
import 'package:flutter_spinkit_szw/widget/core/AnimStyle.dart';
import 'package:flutter_spinkit_szw/widget/core/Sprite.dart';
import 'package:flutter_spinkit_szw/widget/sprites/DoubleBounceSprite.dart';
import 'package:get/get.dart';

class LoadingWidget extends StatefulWidget {
  final double size;
  final AnimStyle animStyle;
  final Color bgColor;
  const LoadingWidget({super.key, this.size = 100, this.animStyle = AnimStyle.PULSE, this.bgColor = Colors.grey});
  @override _LoadingWidgetState createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with TickerProviderStateMixin{
  late Sprite sprite;

  // 这仅是为了让LoadingWidget能每隔一段时间就自我刷新而已
  late Animation<double>? animToRefresh;
  late AnimationController ctrlToRefresh;

  @override
  void initState() {
    super.initState();

    ctrlToRefresh = AnimationController(vsync: this, duration: 1.seconds);
    animToRefresh = Tween(begin: 0.0, end: 1.0).animate(ctrlToRefresh);
    ctrlToRefresh.repeat();

    sprite = findSpriteBy(widget.animStyle);
    sprite.init(this);
    sprite.createAnimation();
    sprite.startAnimation();
  }

  @override
  void dispose() {
    ctrlToRefresh.dispose();
    sprite.stopAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(animToRefresh == null) return Container();

    return Container(
      width: widget.size, height: widget.size, color: widget.bgColor,
      child: AnimatedBuilder(
          animation: animToRefresh!,
          builder: (BuildContext context, Widget? child) =>
              CustomPaint(painter: LoadingPainter(sprite)),
      ),
    );
  }

}

class LoadingPainter extends CustomPainter {
  final Sprite sprite;
  LoadingPainter(this.sprite);

  @override bool shouldRepaint(covariant LoadingPainter oldDelegate) {
    return true;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size; //等同于 Rect.fromLTWH(0, 0, size.w, size.h)
    sprite.drawSelf(canvas, rect);
  }

}
