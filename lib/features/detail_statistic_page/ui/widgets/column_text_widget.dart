import 'package:flutter/material.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';

class ColumnTextWidget extends StatelessWidget {
  final String title;
  final String description;
  final CrossAxisAlignment crossAxisAlignment;

  const ColumnTextWidget({
    required this.title,
    required this.crossAxisAlignment,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ,
      children: [
        Text(
          title,
          style: AppTypography.font14Regular,
        ),
        Text(
          description,
          style: AppTypography.font14Regular.copyWith(color: AppColors.gray),
        ),
      ],
    );
  }
}
