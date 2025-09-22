import 'package:flutter/material.dart';
import 'package:nomix/core/theme/app_corners.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/widgets/animate_click.dart';

class CustomButtonNomix extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomButtonNomix({
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TapAnimator(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.gradientPrimaryButton, borderRadius: AppCorners.radius10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Подтвердить',
              style: AppTypography.font15Regular.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
