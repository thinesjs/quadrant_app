import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/AuthRepository/auth_repository.dart';
import 'package:quadrant_app/repositories/UserRepository/models/user.dart';
import 'package:quadrant_app/repositories/UserRepository/user_repository.dart';
import 'package:quadrant_app/utils/helpers/cache/cache_manager.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<ProfileAvatarRemoveRequested>(_onProfileAvatarRemove);
    on<ProfileAvatarUpdateRequested>(_onProfileAvatarChange);
    on<ProfileUpdateRequested>(_onProfileChange);
    on<AppStarted>(_onAppStarted);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthenticationState> emit,
  ) async {
    log("app started", name: "AuthenticationRepository");
    final isLoggedIn = await _authenticationRepository.isLoggedIn();
    if(isLoggedIn){
      await _authenticationRepository.updateTokenFromStorage();

      User? currentUser = await _userRepository.getUser();
      if(currentUser != null){
        return emit(AuthenticationState.authenticated(currentUser));
      }
    }
    return emit(const AuthenticationState.unauthenticated());
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        User? currentUser = await _userRepository.getUser();
  
        return emit(
          currentUser != null
              ? AuthenticationState.authenticated(currentUser)
              : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        // return emit(const AuthenticationState.unknown());  DEBUG:: triggers after app init
    }
  }

  Future<void> _onProfileChange(
    ProfileUpdateRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    User? user = await _authenticationRepository.updateProfile(event.username, event.email);
    if(user != null) return emit(AuthenticationState.authenticated(user));
  }

  Future<void> _onProfileAvatarChange(
    ProfileAvatarUpdateRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    User? user = await _authenticationRepository.changeProfileAvatar(event.imagePath);
    if(user != null) return emit(AuthenticationState.authenticated(user));
  }

  Future<void> _onProfileAvatarRemove(
    ProfileAvatarRemoveRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    User? user = await _authenticationRepository.removeProfileAvatar();
    if(user != null) return emit(AuthenticationState.authenticated(user));
  }

  Future<void> _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await CacheManager.remove("/api/login");
    await _authenticationRepository.logOut();
  }
}