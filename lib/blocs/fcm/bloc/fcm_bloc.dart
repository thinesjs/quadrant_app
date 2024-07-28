import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/AuthRepository/auth_repository.dart';

part 'fcm_event.dart';
part 'fcm_state.dart';

class FcmBloc extends Bloc<FcmEvent, FcmState> {
  FcmBloc({ required AuthenticationRepository authenticationRepository }) : _authenticationRepository = authenticationRepository, super(FcmInitial()) {
    on<FetchFcmStatus>(_onCheckFcmTokenStatus);
    on<UpdateFcmTokenStatus>(_onUpdateFcmTokenStatus);
  }

  final AuthenticationRepository _authenticationRepository;

  Future<void> _onCheckFcmTokenStatus(
    FetchFcmStatus event,
    Emitter<FcmState> emit,
  ) async {
    emit(FcmLoading());
    try {
      final response = await _authenticationRepository.checkFcmToken();
      emit(FcmTokenStatusLoaded(status: response));
    } catch (error) {
      if(error is DioException && error.response!.data['success'] == false){
        emit(const FcmTokenStatusLoaded(status: false));
      }else{
        emit(FcmError());
      }
    }
  }

  Future<void> _onUpdateFcmTokenStatus(
    UpdateFcmTokenStatus event,
    Emitter<FcmState> emit,
  ) async {
    emit(FcmLoading());
    try {
      if (event.currentStatus) {
        final response = await _authenticationRepository.unregisterFcmToken();
        emit(const FcmTokenStatusLoaded(status: false));
      }else{
        final response = await _authenticationRepository.registerFcmToken();
        emit(const FcmTokenStatusLoaded(status: true));
      }
    } catch (_) {
      if(_ is DioException){
        log(_.response!.data.toString())
;      }
      emit(FcmError());
    }
  }
}
