import 'package:nomix/features/home_page/domain/entity/auth_data_entity.dart';

class AuthDataModel extends AuthDataEntity {
  const AuthDataModel({
    int? id,
    String? photoUrl,
    String? message,
    int? code,
    String? token,
  }) : super(
          id: id,
          message: message,
          code: code,
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
      message: json['message'] as String?,
      code: (json['code'] as num).toInt(),
      photoUrl: json['photoUrl'] as String?,
      token: json['token'] as String,
    );
  }
}
