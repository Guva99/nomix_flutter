
import 'package:flutter/material.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:shimmer/shimmer.dart';

class WavyShimmerText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const WavyShimmerText({
    super.key,
    required this.text,
    required this.style,
    this.duration = const Duration(seconds: 4),
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.primaryBlueLight,
      highlightColor: AppColors.accentColor,
      period: duration,
      direction: ShimmerDirection.ltr,
      child: Text(text, style: style),
    );
  }
}
