import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CircleTabIndicator extends Decoration {
  late final Color color;
  late double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  late final double radius;
  late Color color;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    late Paint _paint;
    _paint = Paint()..color = color;
    _paint = _paint..isAntiAlias = true;
    final Offset circleOffset = offset +
        Offset(configuration.size!.width / 2,
            configuration.size!.height - radius * 2);
    canvas.drawCircle(circleOffset, radius, _paint);
  }
}
