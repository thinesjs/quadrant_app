import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, this.name, this.email, this.email_verified_at, this.avatar, this.role, this.created_at);

  final String id;
  final String name;
  final String email;
  final String email_verified_at;
  final String avatar;
  final String role;
  final String created_at;

  @override
  List<Object> get props => [id, name, email, email_verified_at, avatar, role, created_at];

  static const empty = User('NaN', 'NaN', 'NaN', 'NaN', '', 'NaN', 'NaN');
}