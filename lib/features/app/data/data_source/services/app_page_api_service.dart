import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nomix/features/app/data/data_source/api/app_page_api.dart';
import 'package:nomix/features/home_page/data/data_source/api/home_page_api.dart';
import 'package:nomix/features/home_page/data/model/auth_data_model.dart';

@lazySingleton
class AppPageApiService implements AppPageApi {
  final Dio dio;

  AppPageApiService(this.dio);

  @override
  Future<AuthDataModel?> addUserTelegram({
    required int id,
    // required String token,
    String? firstName,
    String? lastName,
    String? username,
    String? photoUrl,
  }) async {
    final response = await dio.post<Map<String, dynamic>>(
      'telegram/login',
      data: {
        "firstName": firstName,
        "lastName": lastName,
        "username": username,
        "photoUrl": photoUrl,
        "id": id,
        // "token": token,
      },
    );
    if (response.statusCode == 200 && response.data != null) {
      return AuthDataModel.fromJson(response.data);
    } else {
      return null;
    }
  }
}
