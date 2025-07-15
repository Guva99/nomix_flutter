
import 'package:flutter/material.dart';
import 'package:nomix/core/theme/app_corners.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/widgets/animate_click.dart';

class ListTileContainerWidget extends StatelessWidget {
  final String leadingPath;
  final String title;
  final VoidCallback? onTap;

  const ListTileContainerWidget({
    super.key,
    required this.leadingPath,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TapAnimator(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: AppCorners.radius10,
          ),
          child: ListTile(
            leading: Image.asset(
              leadingPath,
              height: 40,
            ),
            title: Text(
              title,
              style: AppTypography.font14Regular.copyWith(fontWeight: FontWeight.w600),
            ),
            trailing: const Icon(
              Icons.navigate_next_outlined,
              color: AppColors.gray,
            ),
          ),
        ),
      ),
    );
  }
}