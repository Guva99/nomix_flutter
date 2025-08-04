import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nomix/features/approve_receipts_page/domain/entity/reciepts_item_entity.dart';
import 'package:nomix/features/approve_receipts_page/domain/repository/approve_receipts_page_repository.dart';
import 'package:nomix/features/home_page/domain/entity/auth_data_entity.dart';
import 'package:nomix/features/home_page/domain/repository/home_page_repository.dart';

@lazySingleton
class ApproveReceiptsUseCase {
  const ApproveReceiptsUseCase({required this.approveReceiptsRepository});

  final ApproveReceiptsRepository approveReceiptsRepository;

  Future<ReceiptEntity?> getlastCheckModel(int userId) async {
    try {
      final data = await approveReceiptsRepository.getlastCheckModel(userId);
      return data;
    } on DioException catch (e) {
      return null;
      // throw FailedRequestException(
      //   requestOptions: e.requestOptions,
      // );
    }
  }
}


