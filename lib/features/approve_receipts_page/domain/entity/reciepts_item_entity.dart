import 'package:equatable/equatable.dart';

class ReceiptItemEntity extends Equatable {
  final int? id;
  final String? name;
  final double? price;
  final String? category;
  final int? categoryId;
  final String? subcategory;
  final int? subcategoryId;

  const ReceiptItemEntity({
    this.id,
    this.name,
    this.price,
    this.category,
    this.categoryId,
    this.subcategory,
    this.subcategoryId,
  });

  ReceiptItemEntity copyWith({
    int? id,
    String? name,
    double? price,
    String? category,
    int? categoryId,
    String? subcategory,
    int? subcategoryId,
  }) {
    return ReceiptItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      category: category ?? this.category,
      categoryId: categoryId ?? this.categoryId,
      subcategory: subcategory ?? this.subcategory,
      subcategoryId: subcategoryId ?? this.subcategoryId,
    );
  }

  @override
  List<Object?> get props => [id, name, price, category, categoryId, subcategory, subcategoryId];
}

/// Сущность чека
class ReceiptEntity extends Equatable {
  final bool? isReceipt;
  final String? store;
  final DateTime? dateTime;
  final double? total;
  final String? currency;
  final List<ReceiptItemEntity>? items;

  const ReceiptEntity({
    this.isReceipt,
    this.store,
    this.dateTime,
    this.total,
    this.currency,
    this.items,
  });

  ReceiptEntity copyWith({
    bool? isReceipt,
    String? store,
    DateTime? dateTime,
    double? total,
    String? currency,
    List<ReceiptItemEntity>? items,
  }) {
    return ReceiptEntity(
      isReceipt: isReceipt ?? this.isReceipt,
      store: store ?? this.store,
      dateTime: dateTime ?? this.dateTime,
      total: total ?? this.total,
      currency: currency ?? this.currency,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props => [
        isReceipt,
        store,
        dateTime,
        total,
        currency,
        items,
      ];
}
