import 'package:flutter/material.dart';
import 'package:nomix/core/enums/filtered_date_enum.dart';
import 'package:nomix/core/theme/app_corners.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/utils/buisness_utils.dart';
import 'package:nomix/core/widgets/animate_click.dart';
import 'package:nomix/core/widgets/app_bottom_sheets.dart';
import 'package:nomix/features/detail_statistic_page/ui/widgets/category_element_widget.dart';
import 'package:nomix/features/detail_statistic_page/ui/widgets/column_text_widget.dart';
import 'package:nomix/features/home_page/domain/entity/receipts_entity.dart';

class ReceiptsWidget extends StatefulWidget {
  const ReceiptsWidget({super.key});

  @override
  State<ReceiptsWidget> createState() => _ReceiptsWidgetState();
}

class _ReceiptsWidgetState extends State<ReceiptsWidget> {
  late FilteredDateEnum _currentFilter;

  @override
  void initState() {
    _currentFilter = FilteredDateEnum.Week;
    super.initState();
  }

  final List<ReceiptsEntity> receiptsList = [
    ReceiptsEntity(
      storeName: 'Пятерочка',
      address: 'ул. Маршала Чуйкова 9',
      amount: 1540.99,
      purchaseDate: DateTime(2025, 4, 7, 12, 23),
    ),
    ReceiptsEntity(
      storeName: 'Перекресток',
      address: 'ул. Маршала Тухачевского',
      amount: 1540.99,
      purchaseDate: DateTime(2025, 4, 7, 12, 23),
    ),
    ReceiptsEntity(
      storeName: 'The Бык',
      address: 'ул. Маршала Тухачевского',
      amount: 1540.99,
      purchaseDate: DateTime(2025, 4, 7, 12, 23),
    ),
    ReceiptsEntity(
      storeName: 'Zarra',
      address: 'ул. Маршала Тухачевского',
      amount: 1540.99,
      purchaseDate: DateTime(2025, 4, 7, 12, 23),
    ),
    ReceiptsEntity(
      storeName: 'Пятерочка',
      address: 'ул. Маршала Чуйкова 9',
      amount: 1540.99,
      purchaseDate: DateTime(2025, 4, 7, 12, 23),
    ),
    ReceiptsEntity(
      storeName: 'Перекресток',
      address: 'ул. Маршала Тухачевского',
      amount: 1540.99,
      purchaseDate: DateTime(2025, 4, 7, 12, 23),
    ),
    ReceiptsEntity(
      storeName: 'Zarra',
      address: 'ул. Маршала Тухачевского',
      amount: 1540.99,
      purchaseDate: DateTime(2025, 4, 7, 12, 23),
    ),
    ReceiptsEntity(
      storeName: 'Пятерочка',
      address: 'ул. Маршала Чуйкова 9',
      amount: 1540.99,
      purchaseDate: DateTime(2025, 4, 7, 12, 23),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          SizedBox(
            width: double.infinity,
            child: AnimatedSegmentedControl(
              segments: const ['День', 'Неделя', 'Месяц'],
              initialIndex: _currentFilter.index,
              backgroundColor: AppColors.gray100,
              textColor: AppColors.gray,
              selectedTextColor: AppColors.black50,
              onSegmentChosen: (idx) {
                final f = FilteredDateEnum.values[idx];
                setState(() => _currentFilter = f);
              },
            ),
          ),
          SizedBox(height: 15),
          Column(
            children: receiptsList.map((path) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 6),
                    TapAnimator(
                      onTap: () {
                        showCustomSheet(
                          context: context,
                          bgColor: AppColors.bgWhite,
                          builder: (_) => SizedBox(
                            height: 200,
                            child: Center(
                              child: Text(
                                'Открывается чек',
                                style: AppTypography.font18Regular.bold,
                              ),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          border: Border.all(color: AppColors.white, width: 0.5),
                          borderRadius: AppCorners.radius10,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.1),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(1, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ColumnTextWidget(
                                  title: path.storeName,
                                  description: path.address,
                                  crossAxisAlignment: CrossAxisAlignment.start),
                              ColumnTextWidget(
                                  title: path.amount.toString(),
                                  description:
                                      '${path.purchaseDate.day}.${path.purchaseDate.month}.${path.purchaseDate.year}',
                                  crossAxisAlignment: CrossAxisAlignment.end),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
