
import 'dart:math';

import 'package:flutter/material.dart';

class CircularRevealClipper extends CustomClipper<Path> {
  final double revealPercent;

  CircularRevealClipper({required this.revealPercent});

  @override
  Path getClip(Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = sqrt((size.width * size.width + size.height * size.height).toDouble()) + 20;
    final radius = maxRadius * revealPercent;

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addOval(Rect.fromCircle(center: center, radius: radius))
      ..fillType = PathFillType.evenOdd;

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
