import 'package:nomix/features/approve_receipts_page/domain/entity/reciepts_item_entity.dart';

class ReceiptModel extends ReceiptEntity {
  const ReceiptModel({
    bool? isReceipt,
    String? store,
    DateTime? dateTime,
    double? total,
    String? currency,
    List<ReceiptItemModel>? items,
  }) : super(
    isReceipt: isReceipt,
    store: store,
    dateTime: dateTime,
    total: total,
    currency: currency,
    items: items,
  );

  factory ReceiptModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const ReceiptModel();
    }
    // Собираем items, если есть
    final rawItems = json['items'] as List<dynamic>?;
    final itemModels = rawItems?.map((e) => ReceiptItemModel.fromJson(e as Map<String, dynamic>?)).toList();

    // Парсим дату и время, если оба есть
    DateTime? dt;
    if (json['date'] is String && json['time'] is String) {
      try {
        dt = DateTime.parse('${json['date']}T${json['time']}');
      } catch (_) {
        dt = null;
      }
    }

    return ReceiptModel(
      isReceipt: json['is_receipt'] as bool?,
      store: json['store'] as String?,
      dateTime: dt,
      total: (json['total'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      items: itemModels,
    );
  }

  Map<String, dynamic?> toJson() => {
    'is_receipt': isReceipt,
    'store': store,
    'date': dateTime?.toIso8601String().split('T').first,
    'time': dateTime == null
        ? null
        : '${dateTime!.hour.toString().padLeft(2, '0')}:'
        '${dateTime!.minute.toString().padLeft(2, '0')}',
    'total': total,
    'currency': currency,
    'items': items?.map((e) => (e as ReceiptItemModel).toJson()).toList(),
  };
}

class ReceiptItemModel extends ReceiptItemEntity {
  const ReceiptItemModel({
    String? name,
    double? price,
    String? category,
    int? categoryId,
    String? subcategory,
    int? subcategoryId,
  }) : super(
          name: name,
          price: price,
          category: category,
          categoryId: categoryId,
          subcategory: subcategory,
          subcategoryId: subcategoryId,
        );

  factory ReceiptItemModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return const ReceiptItemModel();
    }
    return ReceiptItemModel(
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      category: json['category'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      subcategory: json['subcategory'] as String?,
      subcategoryId: (json['subcategory_id'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic?> toJson() => {
        'name': name,
        'price': price,
        'category': category,
        'category_id': categoryId,
        'subcategory': subcategory,
        'subcategory_id': subcategoryId,
      };
}
