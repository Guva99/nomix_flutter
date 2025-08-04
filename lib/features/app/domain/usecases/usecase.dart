import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nomix/features/app/domain/repository/app_page_repository.dart';
import 'package:nomix/features/home_page/domain/entity/auth_data_entity.dart';
import 'package:nomix/features/home_page/domain/repository/home_page_repository.dart';

@lazySingleton
class AppPageUseCase {
  const AppPageUseCase({required this.appPageRepository});

  final AppPageRepository appPageRepository;

  Future<AuthDataEntity?> addUserTelegram({
    required int id,
    // required String token,
    String? firstName,
    String? lastName,
    String? username,
    String? photoUrl,
  }) async {
    try {
      final data = await appPageRepository.addUserTelegram(
        id: id,
        // token: token,
        firstName: firstName,
        lastName: lastName,
        username: username,
        photoUrl: photoUrl,
      );
      return data;
    } on DioException catch (e) {
      return null;
      // throw FailedRequestException(
      //   requestOptions: e.requestOptions,
      // );
    }
  }
}
