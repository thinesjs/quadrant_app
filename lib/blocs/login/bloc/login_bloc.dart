import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:quadrant_app/blocs/login/models/password.dart';
import 'package:quadrant_app/blocs/login/models/email.dart';
import 'package:quadrant_app/repositories/AuthRepository/auth_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Email.dirty(event.username);
    emit(
      state.copyWith(
        email: username,
        isValid: Formz.validate([state.password, username]),
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password, state.email]),
      ),
    );
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      try {
        final String? response = await _authenticationRepository.login(
          email: state.email.value,
          password: state.password.value, 
          device_name: deviceInfo.deviceInfo.toString(),
        );

        if (response != null) {
          await _authenticationRepository.updateLoggedIn(true);
          await _authenticationRepository.updateToken(response);
          await _authenticationRepository.registerFcmToken();

          emit(state.copyWith(status: FormzSubmissionStatus.success));
        } else {
          // add(LogoutRequested());
          emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }

        // emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}