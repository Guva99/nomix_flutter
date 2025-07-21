import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nomix/core/enums/filtered_date_enum.dart';
import 'package:nomix/core/theme/app_corners.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/utils/buisness_utils.dart';
import 'package:nomix/core/widgets/animate_click.dart';
import 'package:nomix/core/widgets/app_bottom_sheets.dart';
import 'package:nomix/core/widgets/collapse_animated.dart';
import 'package:nomix/features/detail_statistic_page/domain/entity.dart';
import 'package:nomix/features/detail_statistic_page/ui/page/detail_statistic_page.dart';
import 'package:nomix/features/detail_statistic_page/ui/state/detail_statistic_bloc.dart';
import 'package:nomix/features/detail_statistic_page/ui/widgets/column_text_widget.dart';

class CategoryElementWidget extends StatefulWidget {
  final CategoryProduct         data;
  final ScrollController        scrollController;
  final FilteredDateEnum        selectedFilter;
  final ValueChanged<FilteredDateEnum> onFilterChanged;

  const CategoryElementWidget({
    Key? key,
    required this.data,
    required this.scrollController,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  State<CategoryElementWidget> createState() => _CategoryElementWidgetState();
}

class _CategoryElementWidgetState extends State<CategoryElementWidget> {
  bool isCollapsed = true;
  final GlobalKey _key = GlobalKey();
   late FilteredDateEnum _currentFilter;

  void _toggle() {
    setState(() => isCollapsed = !isCollapsed);

    if (!isCollapsed) {
      Future.delayed(const Duration(milliseconds: 300), () {
        final box = _key.currentContext?.findRenderObject() as RenderBox?;
        if (box != null) {
          final dy = box
              .localToGlobal(Offset.zero)
              .dy;
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
  void initState() {
    super.initState();
    _currentFilter = widget.selectedFilter;
  }

  @override
  Widget build(BuildContext context) {
    final detailStatisticBloc = context.read<DetailStatisticBloc>();

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
                  Image.asset(widget.data.image, height: 60),
                  const SizedBox(width: 10),
                  Expanded(
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
                            turns: isCollapsed ? 1 : 1.25,
                            duration: const Duration(milliseconds: 200),
                            child: const Icon(Icons.navigate_next_outlined, color: AppColors.gray),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            // CollapseAnimatedBox с контентом и единственным фильтром сверху
            CollapseAnimatedBox(
              isCollapse: isCollapsed,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Column(
                  children: [
                    // Фильтр: рисуем его один раз
                    SizedBox(
                      width: double.infinity,
                      child: AnimatedSegmentedControl(
                        segments: ['День', 'Неделя', 'Месяц'],
                        initialIndex: _currentFilter.index,
                        backgroundColor: AppColors.gray100,
                        textColor: AppColors.gray,
                        selectedTextColor: AppColors.black50,
                        onSegmentChosen: (idx) {
                          final f = FilteredDateEnum.values[idx];
                          setState(() => _currentFilter = f);
                          widget.onFilterChanged(f);
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...widget.data.foodPath.map((path) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(path.title, style: AppTypography.font14Regular.bold),
                                Text(path.price, style: AppTypography.font14Regular.bold),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Column(
                              children: path.products.map((p) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 30, bottom: 6.0),
                                  child: TapAnimator(
                                    onTap: () {
                                      showCustomSheet(
                                        context: context,
                                        bgColor: AppColors.bgWhite,
                                        builder: (_) =>
                                            SizedBox(
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
                                            ColumnTextWidget(title: p.title,
                                                description: p.weight,
                                                crossAxisAlignment: CrossAxisAlignment.start),
                                            ColumnTextWidget(title: p.price,
                                                description: BusinessUtils.formatPeriod(_currentFilter, p.data),
                                                crossAxisAlignment: CrossAxisAlignment.end),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}// helper внутри State:



class AnimatedSegmentedControl extends StatefulWidget {
  final List<String> segments;
  final ValueChanged<int>? onSegmentChosen;
  final int initialIndex;
  final Color backgroundColor;
  final Color selectedColor;
  final Color textColor;
  final Color selectedTextColor;
  final Duration animationDuration;
  final double borderRadius;
  final double height;

  const AnimatedSegmentedControl({
    Key? key,
    required this.segments,
    this.onSegmentChosen,
    this.initialIndex = 0,
    this.backgroundColor = const Color(0xFFF0F0F0),
    this.selectedColor = AppColors.white,
    this.textColor = Colors.grey,
    this.selectedTextColor = Colors.white,
    this.animationDuration = const Duration(milliseconds: 250),
    this.borderRadius = 10.0,
    this.height = 40.0,
  }) : super(key: key);

  @override
  _AnimatedSegmentedControlState createState() => _AnimatedSegmentedControlState();
}

class _AnimatedSegmentedControlState extends State<AnimatedSegmentedControl> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final totalWidth = constraints.maxWidth;
      final segmentWidth = totalWidth / widget.segments.length;

      return Container(
        width: totalWidth,
        height: widget.height,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: Stack(
          children: [
            // Анимированный фон-верхушка
            AnimatedPositioned(
              left: _currentIndex * segmentWidth,
              top: 0,
              duration: widget.animationDuration,
              curve: Curves.easeInOut,
              child: Container(
                width: segmentWidth,
                height: widget.height,
                decoration: BoxDecoration(
                  color: widget.selectedColor,
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),

            // Собственно кнопки
            Row(
              children: List.generate(widget.segments.length, (index) {
                final isSelected = index == _currentIndex;
                return GestureDetector(
                  behavior: HitTestBehavior.translucent, // ← вот эта строка
                  onTap: () {
                    setState(() {
                      _currentIndex = index;
                    });
                    widget.onSegmentChosen?.call(index);
                  },
                  child: SizedBox(
                    width: segmentWidth,
                    height: widget.height,
                    child: Center(
                      child: Text(
                        widget.segments[index],
                        style: AppTypography.font15Regular.copyWith(
                          color: isSelected ? widget.selectedTextColor : widget.textColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}
