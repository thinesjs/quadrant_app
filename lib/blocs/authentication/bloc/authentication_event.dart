part of 'authentication_bloc.dart';

sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

final class AppStarted extends AuthenticationEvent {}
final class _AuthenticationStatusChanged extends AuthenticationEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthenticationStatus status;
}

final class ProfileUpdateRequested extends AuthenticationEvent {
  final String username;
  final String email;

  const ProfileUpdateRequested(this.username, this.email);

  @override
  List<Object> get props => [username, email];
}

final class ProfileAvatarUpdateRequested extends AuthenticationEvent {
  final String imagePath;

  const ProfileAvatarUpdateRequested(this.imagePath);

  @override
  List<Object> get props => [imagePath];
}

final class ProfileAvatarRemoveRequested extends AuthenticationEvent {}

final class AuthenticationLogoutRequested extends AuthenticationEvent {}