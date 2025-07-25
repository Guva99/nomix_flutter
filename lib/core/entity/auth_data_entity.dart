import 'package:equatable/equatable.dart';

class AuthUserEntity extends Equatable {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? username;
  final String? photoUrl;
  final String? token;

  const AuthUserEntity({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.photoUrl,
    this.token,
  });

  @override
  List<Object?> get props => [id, firstName, lastName, username, photoUrl, token];
}
