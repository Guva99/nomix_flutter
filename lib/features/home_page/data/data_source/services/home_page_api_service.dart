import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:nomix/features/home_page/data/data_source/api/home_page_api.dart';
import 'package:nomix/features/home_page/data/model/auth_data_model.dart';

@lazySingleton
class HomePageApiService  implements HomePageApi{
  final Dio dio;

  HomePageApiService(this.dio);

  @override
  Future<void> addUserTelegram({
    required int id,
    required String token,
    String? firstName,
    String? lastName,
    String? username,
    String? photoUrl,
  }) async {

       await dio.post<Map<String, dynamic>>(
        'data/addUserTelegram',
        data: {
          "firstName": firstName,
          "lastName": lastName,
          "username": username,
          "photoUrl": photoUrl,
          "token": token,
        },
      );

  }
}
