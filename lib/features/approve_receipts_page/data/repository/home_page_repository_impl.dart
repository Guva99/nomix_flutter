import 'package:injectable/injectable.dart';
import 'package:nomix/features/approve_receipts_page/data/model/reciepts_item_model.dart';
import 'package:nomix/features/approve_receipts_page/data/source/services/approve_receipts_page_api_service.dart';
import 'package:nomix/features/approve_receipts_page/domain/repository/approve_receipts_page_repository.dart';

@LazySingleton(as: ApproveReceiptsRepository)
class ApproveReceiptsRepositoryImpl extends ApproveReceiptsRepository {
  ApproveReceiptsRepositoryImpl({required this.approveReceiptsApiService});

  final ApproveReceiptsApiService approveReceiptsApiService;

  @override
  Future<ReceiptModel?>getlastCheckModel(int userId) async {
    return await approveReceiptsApiService.getlastCheckModel(userId);
  }
}
