import 'package:nomix/features/home_page/domain/entity/auth_data_entity.dart';

class AuthDataModel extends AuthDataEntity {
  const AuthDataModel({
    required int id,
    String? firstName,
    String? lastName,
    String? username,
    String? photoUrl,
    required String token,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          username: username,
          photoUrl: photoUrl,
          token: token,
        );

  /// Фабрика для создания из JSON
  factory AuthDataModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw ArgumentError('AuthDataModel.fromJson: json is null');
    }

    return AuthDataModel(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      username: json['username'] as String?,
      photoUrl: json['photoUrl'] as String?,
      token: json['token'] as String,
    );
  }
}
