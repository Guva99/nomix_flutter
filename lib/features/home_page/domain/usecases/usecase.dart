import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nomix/features/home_page/domain/entity/auth_data_entity.dart';
import 'package:nomix/features/home_page/domain/repository/home_page_repository.dart';

@lazySingleton
class HomePageUseCase {
  const HomePageUseCase({required this.homePageRepository});

  final HomePageRepository homePageRepository;

  Future<AuthDataEntity?> addUserTelegram({
    required int id,
    // required String token,
    String? firstName,
    String? lastName,
    String? username,
    String? photoUrl,
  }) async {
    try {
      final data = await homePageRepository.addUserTelegram(
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
