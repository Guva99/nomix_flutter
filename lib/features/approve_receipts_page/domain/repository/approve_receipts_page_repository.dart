import 'package:nomix/features/approve_receipts_page/domain/entity/reciepts_item_entity.dart';
import 'package:nomix/features/home_page/domain/entity/auth_data_entity.dart';

abstract class ApproveReceiptsRepository {
  Future<ReceiptEntity?> getlastCheckModel(int userId);
}
