import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:nomix/core/extensions/string_extensions.dart';
import 'package:nomix/core/resources/resources.dart';
import 'package:nomix/core/theme/app_corners.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';
import 'package:nomix/core/widgets/app_custom_button.dart';
import 'package:nomix/core/widgets/collapse_animated.dart';
import 'package:nomix/features/approve_receipts_page/domain/entity/category.dart';
import 'package:nomix/features/approve_receipts_page/domain/entity/reciepts_item_entity.dart';
import 'package:nomix/features/approve_receipts_page/ui/widgets/product_text_field_widgets.dart';

class EditProductPage extends StatefulWidget {
  final ReceiptItemEntity item;
  final ValueChanged<ReceiptItemEntity> onSave;

  const EditProductPage({required this.item, required this.onSave, Key? key}) : super(key: key);

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> with SingleTickerProviderStateMixin {
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
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    // Считаем примерную высоту нашего контента:
    const headerH = 100.0; // приблизительно handle + заголовок
    const footerH = 80.0; // кнопки «Да/Нет»
    const perFieldH = 60.0; // примерно высота одного TextField + отступы
    final fieldsCount = 400;
    final contentH = headerH + footerH + perFieldH * fieldsCount;
    final screenH = MediaQuery.of(context).size.height;
    final maxH = screenH * 0.9;
    final sheetH = contentH.clamp(0.0, maxH);

    return AnimatedPadding(
      duration: const Duration(milliseconds: 100),
      padding: EdgeInsets.only(bottom: bottomInset),
      child: FractionallySizedBox(
        heightFactor: sheetH / screenH,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: SafeArea(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                        top: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Редактировать',
                              style: AppTypography.font22Regular.bold,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
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

                          CollapseAnimatedBox(
                            isCollapse: _selectedCategoryId == 6,
                            duration: const Duration(milliseconds: 550),
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                                    child: AnimationLimiter(
                                      // ключ, завязанный на ids подкатегорий
                                      key: ValueKey(subs.map((s) => s.id).join(',')),
                                      child: Wrap(
                                        spacing: 8,
                                        runSpacing: 8,
                                        children: subs.map((sub) {
                                          final selected = sub.id == _selectedSubcategoryId;
                                          return AnimationConfiguration.staggeredList(
                                            position: subs.indexOf(sub), // лучше индекс в списке
                                            duration: const Duration(milliseconds: 375),
                                            child: SlideAnimation(
                                              verticalOffset: 50.0,
                                              child: FadeInAnimation(
                                                child: ChoiceChip(
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
                                                ),
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
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
                        ],
                      ),
                    ),
                  ),
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
                      selectedSub =
                          _subcategories[_selectedCategoryId]!.firstWhere((s) => s.id == _selectedSubcategoryId);
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
        ),
      ),
    );
  }
}
