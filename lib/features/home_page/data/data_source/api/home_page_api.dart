import 'package:nomix/features/home_page/data/model/auth_data_model.dart';

abstract class HomePageApi {
  Future<AuthDataModel?> addUserTelegram({
    required int id,
    // required String token,
    String? firstName,
    String? lastName,
    String? username,
    String? photoUrl,
  });
}
