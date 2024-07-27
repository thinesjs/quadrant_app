import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/EwalletRepository/ewallet_repository.dart';
import 'package:quadrant_app/repositories/EwalletRepository/models/wallet_qr_response.dart';

part 'ewallet_qr_event.dart';
part 'ewallet_qr_state.dart';

class EwalletQrBloc extends Bloc<EwalletQrEvent, EwalletQrState> {
  EwalletQrBloc({ required EwalletRepository ewalletRepository }) : _ewalletRepository = ewalletRepository, super(EwalletQrInitial()) {
    on<FetchWalletQr>(_onFetchWalletQr);
    on<ValidateWalletQr>(_onValidateWalletQr);
  }

  final EwalletRepository _ewalletRepository;

  Future<void> _onFetchWalletQr(
    FetchWalletQr event,
    Emitter<EwalletQrState> emit,
  ) async {
    emit(EwalletQrLoading());
    try {
      final response = await _ewalletRepository.generateQr(event.amount);
      emit(EwalletQrLoaded(walletQr: response!));
    } catch (_) {
      emit(EwalletQrError());
    }
  }

  Future<void> _onValidateWalletQr(
    ValidateWalletQr event,
    Emitter<EwalletQrState> emit,
  ) async {
    emit(EwalletQrLoading());
    try {
      final response = await _ewalletRepository.validateQr(event.ewalletQrId);
      log("done");
      emit(EwalletQrValidated(walletQr: response!));
    } catch (error) {
      if(error is DioException) {
        emit(EwalletQrNotValidated(errorMsg: error.response!.data['message']));
      }else{
        emit(EwalletQrError());
      }
    }
  }
}
