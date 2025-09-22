import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nomix/core/extensions/string_extensions.dart';
import 'package:nomix/core/resources/resources.dart';
import 'package:nomix/core/theme/app_corners.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/widgets/app_bottom_sheets.dart';
import 'package:nomix/core/widgets/app_custom_button.dart';
import 'package:nomix/features/approve_receipts_page/domain/entity/reciepts_item_entity.dart';
import 'package:nomix/features/approve_receipts_page/ui/state/approve_reciepts_bloc.dart';
import 'package:nomix/features/approve_receipts_page/ui/widgets/product_element.dart';

class ApproveReceiptsPage extends StatefulWidget {
  const ApproveReceiptsPage({Key? key}) : super(key: key);

  @override
  _ApproveReceiptsPageState createState() => _ApproveReceiptsPageState();
}

class _ApproveReceiptsPageState extends State<ApproveReceiptsPage> {
  @override
  void initState() {
    super.initState();
    context.read<ApproveReceiptsBloc>().add(const ApproveReceiptsGetModelEvent());
  }

  String _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'продукты':
        return ImageAssets.food;
      case 'здоровье':
        return ImageAssets.health;
      case 'транспорт':
        return ImageAssets.transports;
      case 'шопинг':
        return ImageAssets.cloth;
      default:
        return ImageAssets.other;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ApproveReceiptsBloc, ApproveReceiptsState>(
      builder: (context, state) {
        if (state is! ApproveReceiptsSuccessState) {
          return const Center(child: CircularProgressIndicator());
        }

        final flatItems = state.receiptEntity!.items ?? [];

        // ――― ГРУППИРУЕМ flatItems С СОХРАНЕНИЕМ ГЛОБАЛЬНОГО ИНДЕКСА ―――
        final grouped = <String, Map<String, List<MapEntry<int, ReceiptItemEntity>>>>{};
        flatItems.asMap().forEach((globalIdx, item) {
          final catKey = (item.category ?? 'без категории').toLowerCase();
          final subKey = (item.subcategory ?? 'без подкатегории').toLowerCase();
          grouped.putIfAbsent(catKey, () => {});
          grouped[catKey]!.putIfAbsent(subKey, () => []).add(MapEntry(globalIdx, item));
        });
        final catList = grouped.entries.toList();

        return Scaffold(
          backgroundColor: const Color(0xFFF2F2F2),
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  state.receiptEntity?.store ?? '',
                  style: AppTypography.font20Regular.bold,
                ),
                const SizedBox(height: 7),
                Text(
                  '${state.receiptEntity?.dateTime?.toLocal().toIso8601String().split("T")[0] ?? ''}   '
                  '${state.receiptEntity?.dateTime != null ? DateFormat('HH:mm').format(state.receiptEntity!.dateTime!) : ''}',
                  style: AppTypography.font14Regular,
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ――― ШАПКА ЧЕКА ―――
                              const SizedBox(height: 16),
                              // ――― СЕКЦИИ ПО КАТЕГОРИЯМ ―――
                              for (var indexed in catList.asMap().entries) ...[
                                // Рисуем Divider только если это не первый блок
                                if (indexed.key != 0) Divider(color: AppColors.gray.withValues(alpha: 0.3)),

                                // Категория
                                Row(
                                  children: [
                                    Image.asset(_iconForCategory(indexed.value.key), height: 30),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        indexed.value.key,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      // Суммируем цену в каждой MapEntry через entry.value.price
                                      '${indexed.value.value.values.expand((list) => list) // Iterable<MapEntry<int,ReceiptItemEntity>>
                                          .fold<double>(
                                            0,
                                            (sum, entry) => sum + (entry.value.price ?? 0),
                                          ).toStringAsFixed(2)} ₽',
                                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                // Подкатегории
                                for (var subEntry in indexed.value.value.entries) ...[
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(24, 12, 16, 4),
                                    child: Text(
                                      subEntry.key.capitalize(),
                                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                  // ――― ЭЛЕМЕНТЫ ПОДКАТЕГОРИИ С ГЛОБАЛЬНЫМ ИНДЕКСОМ ―――
                                  ...subEntry.value.map((entry) {
                                    final idx = entry.key; // глобальный индекс
                                    final item = entry.value;
                                    final edited = state.editedItemIds.contains(idx);
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ProductElementWidget(
                                        item: item,
                                        isEdited: edited,
                                        index: idx,
                                        onEdit: (updated) {
                                          context.read<ApproveReceiptsBloc>().add(
                                                ApproveReceiptsEditItemEvent(
                                                  index: idx,
                                                  updatedItem: updated,
                                                ),
                                              );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 140),
                      ],
                    ),
                  ),
                  Positioned(bottom: 10, left: 10, right: 10, child: confirmButton(flatItems, context)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Container confirmButton(List<ReceiptItemEntity> flatItems, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Итого', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                Text(
                  '${flatItems.fold<double>(0, (sum, it) => sum + (it.price ?? 0)).toStringAsFixed(2)} ₽',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomButtonNomix(
              onTap: () {
                final bloc = context.read<ApproveReceiptsBloc>();
                final state = bloc.state;
                if (state is ApproveReceiptsSuccessState) {
                  showConfirmChangesSheet(
                    context,
                    state,
                    // onConfirm:
                    () {
                      bloc.add(const ApproveReceiptsSaveAllEvent());
                      Navigator.of(context).pop();
                    },
                    // onCancel:
                    () => Navigator.of(context).pop(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void showConfirmChangesSheet(
    BuildContext context,
    ApproveReceiptsSuccessState state,
    VoidCallback onConfirm,
    VoidCallback onCancel,
  ) {
    final original = state.originalReceipt?.items!;
    final updated = state.receiptEntity?.items!;
    final changedIndices = state.editedItemIds.toList();

    // 1) Рассчитаем приблизительную высоту содержимого
    final headerH = 100.0;
    final footerH = 80.0;
    final perItemH = 80.0;
    final desiredH = headerH + footerH + perItemH * changedIndices.length;

    // 2) Сколько у нас всего места?
    final screenH = MediaQuery.of(context).size.height;
    final maxSheetH = screenH * 0.9;

    // 3) Итоговая высота
    final sheetH = desiredH.clamp(0.0, maxSheetH);

    showCustomSheet(
      context: context,
      builder: (_) => SizedBox(
        height: sheetH,
        child:

        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              // handle
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // header
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Подтверждаем изменение?',
                      style: AppTypography.font18Regular.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.gradientPrimaryButton,
                    ),
                    child: const Icon(Icons.error_outline, color: Colors.white, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // body — ListView прокручивается, если контента больше, чем sheetH
              Expanded(
                child: ListView.builder(
                  itemCount: changedIndices.length,
                  itemBuilder: (ctx, i) {
                    final idx = changedIndices[i];
                    final oldItem = original![idx];
                    final newItem = updated![idx];
                    final rows = <Widget>[];

                    if (oldItem.name != newItem.name) {
                      rows.add(_buildChangeRow('Название', oldItem.name, newItem.name));
                    }
                    if (oldItem.price != newItem.price) {
                      rows.add(_buildChangeRow(
                        'Цена',
                        '${oldItem.price?.toStringAsFixed(2)} ₽',
                        '${newItem.price?.toStringAsFixed(2)} ₽',
                      ));
                    }
                    if (oldItem.category != newItem.category) {
                      rows.add(_buildChangeRow('Раздел', oldItem.category, newItem.category));
                    }
                    if (oldItem.subcategory != newItem.subcategory) {
                      rows.add(_buildChangeRow('Подкатегория', oldItem.subcategory, newItem.subcategory));
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${i + 1}. ${newItem.name}',
                            style: AppTypography.font16Regular.bold,
                          ),
                          const SizedBox(height: 8),
                          ...rows,
                        ],
                      ),
                    );
                  },
                ),
              ),

              // footer
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: OutlinedButton(
                        onPressed: onCancel,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.accentColor),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('НЕТ', style: AppTypography.font16Regular.copyWith(color: AppColors.accentColor)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration:
                          BoxDecoration(borderRadius: AppCorners.radius10, gradient: AppColors.gradientPrimaryButton),
                      child: Center(
                          child: Text(
                        'Да',
                        style: AppTypography.font16Regular.copyWith(color: AppColors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChangeRow(String label, String? oldVal, String? newVal) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: '$label: ', style: AppTypography.font14Regular),
            TextSpan(text: oldVal, style: AppTypography.font14Regular),
            const WidgetSpan(child: Text(' 🔄 ')),
            TextSpan(text: newVal, style: AppTypography.font14Regular),
          ],
        ),
      ),
    );

  }
}
