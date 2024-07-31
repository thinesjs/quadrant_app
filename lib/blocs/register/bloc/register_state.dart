part of 'register_bloc.dart';

final class RegisterState extends Equatable {
  const RegisterState({
    this.status = FormzSubmissionStatus.initial,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
  });

  final FormzSubmissionStatus status;
  final Username username;
  final Email email;
  final Password password;
  final bool isValid;

  RegisterState copyWith({
    FormzSubmissionStatus? status,
    Username? username,
    Email? email,
    Password? password,
    bool? isValid,
  }) {
    return RegisterState(
      status: status ?? this.status,
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [status, username, email, password];
}