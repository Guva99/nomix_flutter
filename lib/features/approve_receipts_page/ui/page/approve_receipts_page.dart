import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nomix/core/extensions/string_extensions.dart';
import 'package:nomix/core/resources/resources.dart';
import 'package:nomix/core/theme/app_corners.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/widgets/animate_click.dart';
import 'package:nomix/core/widgets/app_bottom_sheets.dart';
import 'package:nomix/core/widgets/shadow_container.dart';
import 'package:nomix/features/approve_receipts_page/domain/entity/category.dart';
import 'package:nomix/features/approve_receipts_page/domain/entity/reciepts_item_entity.dart';
import 'package:nomix/features/approve_receipts_page/ui/state/approve_reciepts_bloc.dart';

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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ――― ШАПКА ЧЕКА ―――
                        const SizedBox(height: 16),
                        // ――― СЕКЦИИ ПО КАТЕГОРИЯМ ―――
                        for (var catEntry in grouped.entries) ...[
                          // Категория
                          Row(
                            children: [
                              Image.asset(_iconForCategory(catEntry.key), height: 30),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  catEntry.key,
                                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                                ),
                              ),
                              Text(
                                // Суммируем цену в каждой MapEntry через entry.value.price
                                '${catEntry.value.values.expand((list) => list) // Iterable<MapEntry<int,ReceiptItemEntity>>
                                    .fold<double>(
                                      0,
                                      (sum, entry) => sum + (entry.value.price ?? 0),
                                    ).toStringAsFixed(2)} ₽',
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Подкатегории
                          for (var subEntry in catEntry.value.entries) ...[
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
                  const SizedBox(height: 15),
                  Container(
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
                  ),
                ],
              ),
            ),
          ),
        );
      },
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

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SizedBox(
        height: sheetH,
        child: Container(
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

class CustomButtonNomix extends StatelessWidget {
  final VoidCallback? onTap;

  const CustomButtonNomix({
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TapAnimator(
      onTap: onTap,
      child: Container(
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(gradient: AppColors.gradientPrimaryButton, borderRadius: AppCorners.radius10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              'Подтвердить',
              style: AppTypography.font15Regular.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

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
        showCustomSheet(
          context: context,
          title: 'Редактировать',
          titleAlign: Alignment.topLeft,
          bgColor: AppColors.bgWhite,
          builder: (_) => EditSettingWidget(
            item: item,
            onSave: onEdit, // передаём callback
          ),
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
                    Text(item.name ?? '', style: AppTypography.font15Regular),
                    const SizedBox(height: 4),
                    // Text('5 шт', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Text(
                '${(item.price ?? 0).toStringAsFixed(2)} ₽',
                style: const TextStyle(fontSize: 16),
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

class EditSettingWidget extends StatefulWidget {
  final ReceiptItemEntity item;
  final ValueChanged<ReceiptItemEntity> onSave;

  const EditSettingWidget({required this.item, required this.onSave, Key? key}) : super(key: key);

  @override
  _EditSettingWidgetState createState() => _EditSettingWidgetState();
}

class _EditSettingWidgetState extends State<EditSettingWidget> with SingleTickerProviderStateMixin {
  // список всех категорий

  int? _selectedCategoryId;
  int? _selectedSubcategoryId;
  final List<Category> _categories = [
    const Category(1, 'Продукты', ImageAssets.foodEmoji),
    const Category(2, 'Заведение', ImageAssets.restaurantEmoji),
    const Category(3, 'Шопинг', ImageAssets.shoppingEmoji),
    const Category(4, 'Транспорт', ImageAssets.transportEmoji),
    const Category(5, 'Здоровье', ImageAssets.healthEmoji),
    const Category(6, 'Прочее', ImageAssets.otherEmoji),
  ];

  // справочник подкатегорий по category_id
  final Map<int, List<Subcategory>> _subcategories = {
    1: [
      const Subcategory(11, 'алкоголь'),
      const Subcategory(12, 'молочные'),
      const Subcategory(13, 'табак'),
      const Subcategory(14, 'овощи и фрукты'),
      const Subcategory(15, 'другие'),
    ],
    2: [
      const Subcategory(11, 'алкоголь'),
      const Subcategory(12, 'еда и напитки'),
      const Subcategory(14, 'другие'),
    ],
    3: [
      const Subcategory(21, 'одежда'),
      const Subcategory(22, 'обувь'),
      const Subcategory(23, 'техника'),
      const Subcategory(24, 'косметика'),
      const Subcategory(25, 'товары для дома'),
      const Subcategory(26, 'другие'),
    ],
    4: [
      const Subcategory(31, 'бензин'),
      const Subcategory(32, 'такси'),
      const Subcategory(33, 'билеты'),
      const Subcategory(34, 'парковка'),
      const Subcategory(35, 'автоуслуги'),
      const Subcategory(36, 'другие'),
    ],
    5: [
      const Subcategory(41, 'аптека'),
      const Subcategory(42, 'медицинские услуги'),
      const Subcategory(43, 'страхование'),
      const Subcategory(44, 'витамины и БАДы'),
      const Subcategory(45, 'другие'),
    ],
  };
  late final AnimationController _shakeController;
  late final Animation<double> _shakeAnim;
  bool _subError = false;

  // Контроллеры
  late TextEditingController _nameController;
  late TextEditingController _amountController;
  late TextEditingController _priceController;

  // Текущие и изначальные выборы

  late final int _initialCategoryId;
  late final int? _initialSubcategoryId;
  late final String _initialName;
  late final String _initialAmount;
  late final String _initialPrice;

  @override
  void initState() {
    super.initState();

    // Сохраняем изначальные значения
    _initialName = widget.item.name ?? '';
    _initialAmount = widget.item.name ?? '';
    _initialPrice = widget.item.price?.toStringAsFixed(2) ?? '';
    _initialCategoryId = widget.item.categoryId ?? _categories.first.id;
    _initialSubcategoryId = widget.item.subcategoryId;
    _shakeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _shakeAnim = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: -8), weight: 1),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: -8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -8, end: 8), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 8, end: 0), weight: 1),
    ]).animate(_shakeController);
    _shakeController.addStatusListener((s) {
      if (s == AnimationStatus.completed) {
        _shakeController.reset();
        setState(() => _subError = false); // возвращаем нормальный цвет рамки
      }
    });
    // Инициализируем контроллеры
    _nameController = TextEditingController(text: _initialName);
    _amountController = TextEditingController(text: _initialAmount);
    _priceController = TextEditingController(text: _initialPrice);

    // Устанавливаем выбранные изначально
    _selectedCategoryId = widget.item.categoryId ?? _categories.first.id;
    _selectedSubcategoryId = widget.item.subcategoryId;
  }

  @override
  void dispose() {
    _shakeController.dispose();
    _nameController.dispose();
    _amountController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _resetAll() {
    setState(() {
      // Сбрасываем контроллеры
      _nameController.text = _initialName;
      _amountController.text = _initialAmount;
      _priceController.text = _initialPrice;

      // Сбрасываем выбор категорий
      _selectedCategoryId = _initialCategoryId;
      _selectedSubcategoryId = _initialSubcategoryId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cats = _categories;
    final subs = _subcategories[_selectedCategoryId] ?? [];

    return SizedBox(
      height: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: cats.map((cat) {
                final selected = cat.id == _selectedCategoryId;
                return ChoiceChip(
                  showCheckmark: false,
                  color: WidgetStateProperty.all<Color>(Colors.transparent),
                  avatar: selected ? Image(image: AssetImage(cat.iconEmoji)) : null,
                  label: Text(cat.name.capitalize()),
                  selected: selected,
                  onSelected: (_) {
                    if (_selectedCategoryId != cat.id) {
                      // пользователь **меняет** раздел на новый
                      setState(() {
                        _selectedCategoryId = cat.id;
                        // сбрасываем подкатегорию только потому, что это **новая** категория
                        _selectedSubcategoryId = null;
                      });
                    }
                  },
                  labelStyle: TextStyle(
                    color: selected ? AppColors.accentColor : AppColors.black,
                  ),
                  backgroundColor: Colors.white,
                  selectedColor: Colors.white,
                  side: BorderSide(
                    color: selected ? AppColors.accentColor : Colors.grey.shade300,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: AppCorners.radius10,
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 24),
          if (_selectedCategoryId != 6)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Подкатегории',
                style: AppTypography.font16Regular.bold,
              ),
            ),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: _shakeAnim,
            builder: (ctx, child) => Transform.translate(
              offset: Offset(_shakeAnim.value, 0),
              child: child,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.transparent,
                    width: 1.5,
                  ),
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: subs.map((sub) {
                    final selected = sub.id == _selectedSubcategoryId;
                    return ChoiceChip(
                      label: Text(sub.name.capitalize()),
                      selected: selected,
                      shape: RoundedRectangleBorder(
                        borderRadius: AppCorners.radius10,
                      ),
                      showCheckmark: false,
                      onSelected: (_) {
                        setState(() {
                          _selectedSubcategoryId = selected ? null : sub.id;
                          _subError = false;
                        });
                      },
                      labelStyle: TextStyle(
                        color: selected ? AppColors.accentColor : AppColors.black,
                      ),
                      backgroundColor: Colors.white,
                      selectedColor: Colors.white,
                      side: BorderSide(
                        color: selected ? AppColors.accentColor : Colors.grey.shade300,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: Wrap(
          //     spacing: 8,
          //     runSpacing: 8,
          //     children: subs.map((sub) {
          //       final selected = sub.id == _selectedSubcategoryId;
          //       return ChoiceChip(
          //         color: WidgetStateProperty.all<Color>(Colors.transparent),
          //         label: Text(sub.name.capitalize()),
          //         selected: selected,
          //         onSelected: (_) {
          //           setState(() {
          //             _selectedSubcategoryId = selected ? null : sub.id;
          //           });
          //         },
          //         labelStyle: TextStyle(
          //           color: selected ? AppColors.accentColor : AppColors.black,
          //         ),
          //         backgroundColor: Colors.white,
          //         selectedColor: Colors.white,
          //         side: BorderSide(
          //           color: selected ? AppColors.accentColor : Colors.grey.shade300,
          //         ),
          //         shape: RoundedRectangleBorder(
          //           borderRadius: AppCorners.radius10,
          //         ),
          //       );
          //     }).toList(),
          //   ),
          // ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ProductForm(
              nameController: _nameController,
              amountController: _amountController,
              priceController: _priceController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CustomButtonNomix(
              onTap: () {
                // 1) Валидация подкатегории
                if (_selectedCategoryId != 6 && _selectedSubcategoryId == null) {
                  setState(() => _subError = true);
                  _shakeController.forward();
                  return;
                }

                // 2) Достаём выбранные справочники
                final selectedCat = _categories.firstWhere((c) => c.id == _selectedCategoryId);
                Subcategory? selectedSub;
                if (_selectedCategoryId != 6) {
                  selectedSub = _subcategories[_selectedCategoryId]!.firstWhere((s) => s.id == _selectedSubcategoryId);
                }

                // 3) Парсим цену
                final priceText = _priceController.text.replaceAll(',', '.');
                final parsedPrice = double.tryParse(priceText) ?? widget.item.price;

                // 4) Собираем новый экземпляр
                final updatedItem = widget.item.copyWith(
                  name: _nameController.text.trim(),
                  price: parsedPrice,
                  categoryId: selectedCat.id,
                  category: selectedCat.name,
                  subcategoryId: selectedSub?.id,
                  subcategory: selectedSub?.name,
                );

                // 5) Явная проверка изменений
                final nameChanged = updatedItem.name != widget.item.name;
                final priceChanged = updatedItem.price != widget.item.price;
                final catChanged = updatedItem.categoryId != widget.item.categoryId;
                final subcatChanged = updatedItem.subcategoryId != widget.item.subcategoryId;

                if (!(nameChanged || priceChanged || catChanged || subcatChanged)) {
                  // Ничего не трогали — закрываем без сохранения
                  Navigator.of(context).pop();
                  return;
                }

                // 6) Есть изменения — сохраняем
                widget.onSave(updatedItem);
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProductForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController amountController;
  final TextEditingController priceController;

  const ProductForm({
    Key? key,
    required this.nameController,
    required this.amountController,
    required this.priceController,
  }) : super(key: key);

  OutlineInputBorder _border(BuildContext ctx) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Наименование
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Наименование продукта',
            labelStyle: AppTypography.font14Regular.copyWith(color: AppColors.gray),
            hintText: 'Например: Бананы',
            filled: true,
            fillColor: Colors.white,
            border: _border(context),
            enabledBorder: _border(context),
            focusedBorder: _border(context).copyWith(
              borderSide: const BorderSide(color: AppColors.accentColor, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          ),
        ),
        const SizedBox(height: 16),

        // Объём/вес/количество
        // TextField(
        //   controller: amountController,
        //   decoration: InputDecoration(
        //     labelText: 'Объём/ вес/ количество',
        //     labelStyle:
        //     AppTypography.font14Regular.copyWith(color: AppColors.gray),
        //     hintText: 'Например: 2 кг',
        //     filled: true,
        //     fillColor: Colors.white,
        //     border: _border(context),
        //     enabledBorder: _border(context),
        //     focusedBorder: _border(context).copyWith(
        //       borderSide:
        //       const BorderSide(color: AppColors.accentColor, width: 1.5),
        //     ),
        //     contentPadding:
        //     const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        //   ),
        // ),
        const SizedBox(height: 16),

        // Цена
        TextField(
          controller: priceController,
          decoration: InputDecoration(
            labelText: 'Цена',
            labelStyle: AppTypography.font14Regular.copyWith(color: AppColors.gray),
            hintText: 'Например: 1300 ₽',
            filled: true,
            fillColor: Colors.white,
            border: _border(context),
            enabledBorder: _border(context),
            focusedBorder: _border(context).copyWith(
              borderSide: const BorderSide(color: AppColors.accentColor, width: 1.5),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          ),
        ),
      ],
    );
  }
}
