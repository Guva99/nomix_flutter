import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nomix/core/resources/resources.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/widgets/animate_click.dart';
import 'package:nomix/core/widgets/app_bottom_sheets.dart';
import 'package:nomix/features/approve_receipts_page/ui/page/edit_product_page.dart';
import 'package:nomix/core/widgets/shadow_container.dart';
import 'package:nomix/features/approve_receipts_page/domain/entity/reciepts_item_entity.dart';

class ProductElementWidget extends StatelessWidget {
  final ReceiptItemEntity item;
  final bool isEdited;
  final int index;
  final ValueChanged<ReceiptItemEntity> onEdit;

  const ProductElementWidget({
    required this.item,
    required this.isEdited,
    required this.index,
    required this.onEdit,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TapAnimator(
      onTap: () {
         showModalBottomSheet(
          context: context,
          isScrollControlled: true,
           backgroundColor: AppColors.accentColor,
           barrierColor: AppColors.accentColor.withOpacity(0.3),          builder: (ctx) {
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: EditProductPage(
                item: item,
                onSave: onEdit,
              ),
            );
          },
        );
      },
      child: ShadowContainer(
        color: isEdited ? AppColors.accentLightColor2 : AppColors.white,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        constraints: const BoxConstraints(
                            maxWidth: 170
                        ),
                        child: Text(item.name ?? '', maxLines: 1,
                          style: AppTypography.font14Regular,
                          overflow: TextOverflow.ellipsis,)),
                    const SizedBox(height: 4),
                    // Text('5 шт', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Text(
                '${(item.price ?? 0).toStringAsFixed(2)} ₽',
                style: AppTypography.font14Regular,
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                VectorAssets.edit,
                color: AppColors.gray,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
