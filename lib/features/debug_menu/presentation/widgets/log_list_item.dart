


import 'package:flutter/material.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/features/debug_menu/entity/log_model.dart';

class LogListItem extends StatelessWidget {

  const LogListItem({super.key, 
    required this.logModel
  });

  final LogModel logModel;

  Widget? getTitleByType(String type, BuildContext context) {
    switch(type) {
      case 'Debug': return Text(
        type,
        style: AppTypography.font20Regular.copyWith(
          color: AppColors.black,
        ),
      );
      case 'Info': return Text(
        type,
        style: AppTypography.font20Regular.copyWith(
          color: AppColors.black,
        ),
      );
      case 'Warning': return Text(
        type,
        style: AppTypography.font20Regular.copyWith(
          color: AppColors.black,
        ),
      );
      case 'Error': return Text(
        type,
        style: AppTypography.font20Regular.copyWith(
          color: AppColors.black,
        ),
      );
      case 'Fatal': return Text(
        type,
        style: AppTypography.font20Regular.copyWith(
          color: AppColors.black,
        ),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 24.0
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            getTitleByType(logModel.type, context) ?? const SizedBox(),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                logModel.name,
                style: AppTypography.font14Regular.copyWith(
                  color: AppColors.black,
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(
                logModel.details.toString(),
                style: AppTypography.font14Regular.copyWith(
                  color: AppColors.black,
                ),
                overflow: TextOverflow.fade,
              ),
            )
          ],
        ),
      ),
    );
  }
}