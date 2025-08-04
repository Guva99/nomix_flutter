import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  final Color? backGroundColor;
  const AppCircularProgressIndicator({
    super.key, this.backGroundColor
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundColor ?? AppColors.white,
      body: const Center(
        child: SizedBox(
          height: 40,
          width: 40,
          child: CircularProgressIndicator(
            color: AppColors.accentColor,
            backgroundColor: AppColors.gray,
          ),
        ),
      ),
    );
  }
}