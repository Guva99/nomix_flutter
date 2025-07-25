import 'package:injectable/injectable.dart';
import 'package:nomix/features/home_page/data/data_source/services/home_page_api_service.dart';
import 'package:nomix/features/home_page/domain/repository/home_page_repository.dart';

@LazySingleton(as: HomePageRepository)
class HomePageRepositoryImpl extends HomePageRepository {
  HomePageRepositoryImpl({required this.authServiceApi});

  final HomePageApiService authServiceApi;

  @override
  Future<void> addUserTelegram({
    required int id,
    required String token,
    String? firstName,
    String? lastName,
    String? username,
    String? photoUrl,
  }) async {
    return await authServiceApi.addUserTelegram(
      id: id,
      token: token,
      firstName: firstName,
      lastName: lastName,
      username: username,
      photoUrl: photoUrl,
    );
  }
}
