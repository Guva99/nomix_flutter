import 'package:equatable/equatable.dart';

class AuthDataEntity extends Equatable {
  final int? id;
  final String? photoUrl;
  final String? message;
  final int? code;
  final String? token;

  const AuthDataEntity({
    this.id,
    this.code,
    this.message,
    this.photoUrl,
    this.token,
  });

  @override
  List<Object?> get props => [id, code, message, photoUrl, token];
}
