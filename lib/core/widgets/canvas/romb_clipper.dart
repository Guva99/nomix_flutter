import 'dart:math';

import 'package:flutter/material.dart';

class DiamondRevealClipper extends CustomClipper<Path> {
  final double revealPercent;

  DiamondRevealClipper({required this.revealPercent});

  @override
  Path getClip(Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    // радиус ромба — максимальная полудлина по ширине или высоте
    final radius = max(size.width, size.height) * revealPercent;

    // вершины ромба: сверху, справа, снизу, слева
    final top    = Offset(cx, cy - radius);
    final right  = Offset(cx + radius, cy);
    final bottom = Offset(cx, cy + radius);
    final left   = Offset(cx - radius, cy);

    // path ромба
    final diamond = Path()
      ..moveTo(top.dx, top.dy)
      ..lineTo(right.dx, right.dy)
      ..lineTo(bottom.dx, bottom.dy)
      ..lineTo(left.dx, left.dy)
      ..close();

    // вычитаем ромб из всего прямоугольника
    return Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addPath(diamond, Offset.zero)
      ..fillType = PathFillType.evenOdd;
  }

  @override
  bool shouldReclip(DiamondRevealClipper old) =>
      old.revealPercent != revealPercent;
}
