import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User(this.id, this.name, this.email, this.email_verified_at, this.created_at, this.updated_at);

  final String? id;
  final String? name;
  final String? email;
  final String? email_verified_at;
  final String? created_at;
  final String? updated_at;

  @override
  List<Object> get props => [id!, name!, email!, email_verified_at!, created_at!, updated_at!];

  static const empty = User('-', '-', '-', '-', '-', '-');
}