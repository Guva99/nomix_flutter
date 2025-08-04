
import 'package:flutter/material.dart';
import 'package:nomix/core/theme/app_corners.dart';
import 'package:nomix/core/theme/app_theme.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  final Color? color;

  const ShadowContainer({required this.child, this.color, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: AppCorners.radius10,
          color: color ?? AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withValues(alpha: 0.1),
              offset: const Offset(1, 1),
              blurRadius: 2,
            )
          ],
        ),
        child: child);
  }
}
