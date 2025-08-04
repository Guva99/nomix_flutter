import 'package:injectable/injectable.dart';
import 'package:nomix/features/app/data/data_source/services/app_page_api_service.dart';
import 'package:nomix/features/app/domain/repository/app_page_repository.dart';
import 'package:nomix/features/home_page/data/data_source/services/home_page_api_service.dart';
import 'package:nomix/features/home_page/data/model/auth_data_model.dart';
import 'package:nomix/features/home_page/domain/repository/home_page_repository.dart';

@LazySingleton(as: AppPageRepository)
class AppPageRepositoryImpl extends AppPageRepository {
  AppPageRepositoryImpl({required this.authServiceApi});

  final AppPageApiService authServiceApi;

  @override
  Future<AuthDataModel?> addUserTelegram({
    required int id,
    // required String token,
    String? firstName,
    String? lastName,
    String? username,
    String? photoUrl,
  }) async {
    return await authServiceApi.addUserTelegram(
      id: id,
      // token: token,
      firstName: firstName,
      lastName: lastName,
      username: username,
      photoUrl: photoUrl,
    );
  }
}
