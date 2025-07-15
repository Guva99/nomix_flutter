
import 'package:flutter/material.dart';
import 'package:nomix/core/theme/app_corners.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/widgets/animate_click.dart';
import 'package:nomix/core/widgets/app_bottom_sheets.dart';
import 'package:nomix/core/widgets/collapse_animated.dart';
import 'package:nomix/features/detail_statistic_page/domain/entity.dart';
import 'package:nomix/features/detail_statistic_page/ui/page/detail_statistic_page.dart';
import 'package:nomix/features/detail_statistic_page/ui/widgets/column_text_widget.dart';

class CategoryElementWidget extends StatefulWidget {
  final Category data;
  final ScrollController scrollController;

  const CategoryElementWidget({
    Key? key,
    required this.data,
    required this.scrollController,
  }) : super(key: key);

  @override
  State<CategoryElementWidget> createState() => _CategoryElementWidgetState();
}

class _CategoryElementWidgetState extends State<CategoryElementWidget> {
  bool isCollapsed = true;
  final GlobalKey _key = GlobalKey();

  void _toggle() {
    setState(() => isCollapsed = !isCollapsed);

    // Прокрутка после раскрытия
    if (!isCollapsed) {
      // Дать время анимации CollapseAnimatedBox (подстройте под вашу длительность)
      Future.delayed(const Duration(milliseconds: 300), () {
        final box = _key.currentContext?.findRenderObject() as RenderBox?;
        if (box != null) {
          // Расстояние от верха экрана до карточки
          final dy = box.localToGlobal(Offset.zero).dy;
          // Целевая позиция: текущий скролл + dy - небольшой отступ сверху
          final target = widget.scrollController.offset + dy - 100;
          widget.scrollController.animateTo(
            target.clamp(
              widget.scrollController.position.minScrollExtent,
              widget.scrollController.position.maxScrollExtent,
            ),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: _key,
      onTap: _toggle,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppCorners.radius10,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Column(
          children: [
            // Заголовок категории
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image(
                    image: AssetImage(widget.data.image),
                    height: 60,
                  ),
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(widget.data.title, style: AppTypography.font16Regular.bold),
                            Text(widget.data.price, style: AppTypography.font16Regular.copyWith(color: AppColors.gray)),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 5,
                          decoration: BoxDecoration(borderRadius: AppCorners.radius10, color: widget.data.color),
                        ),
                        Align(
                            alignment: Alignment.centerRight,
                            child: AnimatedRotation(
                              turns: isCollapsed ? 1 : 1.25, // 0.5 оборота = 180 градусов
                              duration: const Duration(milliseconds: 200),
                              child: const Icon(
                                Icons.navigate_next_outlined,
                                color: AppColors.gray,
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // Скрытый / показанный контент
            CollapseAnimatedBox(
              isCollapse: isCollapsed,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Column(
                  children: widget.data.foodPath.map((path) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Подзаголовок пути траты
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(path.title, style: AppTypography.font14Regular.bold),
                              Text(path.price, style: AppTypography.font14Regular.bold),
                            ],
                          ),
                          const SizedBox(height: 6),
                          // Список продуктов
                          Padding(
                            padding: const EdgeInsets.only(left: 18.0),
                            child: Column(
                              children: path.products.map((p) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: TapAnimator(
                                    onTap: () {
                                      showCustomSheet(
                                        context: context,
                                        bgColor: AppColors.bgWhite,
                                        builder: (_) => SizedBox(
                                          height: 200,
                                          child: Center(
                                            child: Text(
                                              'Хуяк произошла магия с ИИ',
                                              style: AppTypography.font18Regular.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: AppColors.gray, width: 0.5),
                                        borderRadius: AppCorners.radius10,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            ColumnTextWidget(
                                              title: p.title,
                                              description: p.weight,
                                            ),
                                            ColumnTextWidget(
                                              title: p.price,
                                              description: p.id,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
