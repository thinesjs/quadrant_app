part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class RegisterUsernameChanged extends RegisterEvent {
  const RegisterUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

final class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}


final class RegisterPasswordChanged extends RegisterEvent {
  const RegisterPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

final class RegisterRepeatPasswordChanged extends RegisterEvent {
  const RegisterRepeatPasswordChanged(this.repeatPassword);

  final String repeatPassword;

  @override
  List<Object> get props => [repeatPassword];
}

final class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}