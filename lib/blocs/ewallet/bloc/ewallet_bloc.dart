import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/EwalletRepository/ewallet_repository.dart';
import 'package:quadrant_app/repositories/EwalletRepository/models/wallet_reload_response.dart';
import 'package:quadrant_app/repositories/EwalletRepository/models/wallet_response.dart';
import 'package:quadrant_app/repositories/EwalletRepository/models/wallet_transaction_reponse.dart';

part 'ewallet_event.dart';
part 'ewallet_state.dart';

class EwalletBloc extends Bloc<EwalletEvent, EwalletState> {
  EwalletBloc({ required EwalletRepository ewalletRepository }) : _ewalletRepository = ewalletRepository, super(EwalletLoading()) {
    on<FetchWallet>(_onFetchWallet);
    on<FetchWalletTransaction>(_onFetchWalletTransaction);
    on<ReloadWallet>(_onReloadWallet);
    on<RegisterPin>(_onRegisterPin);
    on<VerifyPin>(_onVerifyPin);
  }

  final EwalletRepository _ewalletRepository;

  Future<void> _onFetchWallet(
    FetchWallet event,
    Emitter<EwalletState> emit,
  ) async {
    emit(EwalletLoading());
    try {
      final response = await _ewalletRepository.fetchWallet();
      emit(EwalletLoaded(wallet: response!));
    } catch (_) {
      emit(EwalletError());
    }
  }

  Future<void> _onFetchWalletTransaction(
    FetchWalletTransaction event,
    Emitter<EwalletState> emit,
  ) async {
    emit(EwalletLoading());
    try {
      final response = await _ewalletRepository.fetchWalletTransactions();
      emit(EwalletTransactionsLoaded(transactions: response!));
    } catch (_) {
      emit(EwalletError());
    }
  }

  Future<void> _onReloadWallet(
    ReloadWallet event,
    Emitter<EwalletState> emit,
  ) async {
    emit(EwalletLoading());
    try {
      final response = await _ewalletRepository.reloadWallet(event.reloadAmount);
      emit(EwalletReloadCallbackLoaded(data: response!));
    } catch (_) {
      emit(EwalletError());
    }
  }

  Future<void> _onRegisterPin(
    RegisterPin event,
    Emitter<EwalletState> emit,
  ) async {
    emit(EwalletLoading());
    try {
      final response = await _ewalletRepository.registerPin(event.pinCode);
      emit(EwalletLoaded(wallet: response!));
    } catch (_) {
      emit(EwalletError());
    }
  }

  Future<void> _onVerifyPin(
    VerifyPin event,
    Emitter<EwalletState> emit,
  ) async {
    emit(EwalletLoading());
    try {
      final response = await _ewalletRepository.verifyPin(event.pinCode);
      emit(EwalletLoaded(wallet: response!));
    } catch (_) {
      emit(EwalletError());
    }
  }
}
