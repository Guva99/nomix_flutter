import 'package:nomix/features/approve_receipts_page/data/model/reciepts_item_model.dart';
import 'package:nomix/features/home_page/data/model/auth_data_model.dart';

abstract class ApproveReceiptsApi {
  Future<ReceiptModel?> getlastCheckModel(int userId);
}
