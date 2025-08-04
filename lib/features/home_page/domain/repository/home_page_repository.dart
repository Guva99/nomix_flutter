import 'package:nomix/features/home_page/domain/entity/auth_data_entity.dart';

abstract class HomePageRepository {
  Future<AuthDataEntity?> addUserTelegram({
    required int id,
    // required String token,
    String? firstName,
    String? lastName,
    String? username,
    String? photoUrl,
  });
}
