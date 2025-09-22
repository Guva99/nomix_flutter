import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nomix/features/approve_receipts_page/data/model/reciepts_item_model.dart';
import 'package:nomix/features/approve_receipts_page/data/source/api/approve_receipts_page_api.dart';

@lazySingleton
class ApproveReceiptsApiService implements ApproveReceiptsApi {
  final Dio dio;

  ApproveReceiptsApiService(this.dio);

  @override
  Future<ReceiptModel?> getlastCheckModel(int userId) async {
    return ReceiptModel.fromJson(jsonDecode(rawJson));

    final response = await dio.get(
      'api/bot/edit-check?$userId',
    );

    if (response.statusCode == 200 && response.data != null) {
      return ReceiptModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}

const rawJson = '''
  {
  "is_receipt": true,
  "store": "Пятёрочка",
  "date": "2025-07-19",
  "time": "21:17",
  "total": 1797.00,
  "currency": "RUB",
  "items": [
    {
      "name": "Пакет ПЯТЕРОЧКА 65x40см",
      "price": 9.99,
      "category": "Шопинг",
      "category_id": 2,
      "subcategory": "Другие",
      "subcategory_id": 25
    },
    {
      "name": "Коньяк СТАР. ТРЭВ. 0.25л",
      "price": 429.99,
      "category": "Продукты",
      "category_id": 1,
      "subcategory": "алкоголь",
      "subcategory_id": 11
    },
    {
      "name": "Вино РОЗЕ сух. 0.75л",
      "price": 449.99,
      "category": "Продукты",
      "category_id": 1,
      "subcategory": "алкоголь",
      "subcategory_id": 11
    },
    {
      "name": "Вино РКАЦИТЕЛИ бел. п/сл. 0.75л",
      "price": 449.99,
      "category": "Продукты",
      "category_id": 1,
      "subcategory": "алкоголь",
      "subcategory_id": 11
    },
    {
      "name": "СТИКИ FIIT VELVET ТАБАЧНЫЕ",
      "price": 190.00,
      "category": "Продукты",
      "category_id": 1,
      "subcategory": "табак",
      "subcategory_id": 13
    }
  ]
}

    ''';
