import 'package:flutter/material.dart';
import 'package:nomix/core/theme/app_theme.dart';
import 'package:nomix/core/theme/typography.dart';

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