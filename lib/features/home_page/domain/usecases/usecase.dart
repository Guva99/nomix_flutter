import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nomix/features/home_page/domain/repository/home_page_repository.dart';

@lazySingleton
class HomePageUseCase {
  const HomePageUseCase({required this.homePageRepository});

  final HomePageRepository homePageRepository;

  Future<void> addUserTelegram({
    required int id,
    required String token,
    String? firstName,
    String? lastName,
    String? username,
    String? photoUrl,
  }) async {
    try {
      await homePageRepository.addUserTelegram(
        id: id,
        token: token,
        firstName: firstName,
        lastName: lastName,
        username: username,
        photoUrl: photoUrl,
      );

    } on DioException catch (e) {
      // throw FailedRequestException(
      //   requestOptions: e.requestOptions,
      // );
    }
  }
}
