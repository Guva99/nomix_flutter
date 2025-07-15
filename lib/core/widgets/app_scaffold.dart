

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nomix/core/resources/resources.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/widgets/animate_click.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  const AppScaffold({super.key, required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgWhite,
        appBar: AppBar(
          leadingWidth: 40,
          leading: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            constraints: const BoxConstraints(
              minWidth: kToolbarHeight,
              minHeight: kToolbarHeight,
            ),
            child: TapAnimator(
              onTap: () {},
              child: SvgPicture.asset(
                VectorAssets.notif,
                width: 24,
                height: 24,
              ),
            ),
          ),
          centerTitle: true,
          title: Text(
            title,
            style: AppTypography.font15Regular.copyWith(fontWeight: FontWeight.w600),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              constraints: const BoxConstraints(
                minWidth: kToolbarHeight,
                minHeight: kToolbarHeight,
              ),
              child: TapAnimator(
                onTap: () {
                  // действие по нажатию на аватар
                },
                child: CircleAvatar(
                  backgroundColor: AppColors.black50,
                  radius: 20,
                  child: Text(
                    '🐼',
                    style: AppTypography.font28Regular,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: body

    );
  }
}