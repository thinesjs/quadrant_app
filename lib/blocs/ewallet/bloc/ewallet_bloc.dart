import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/EwalletRepository/ewallet_repository.dart';
import 'package:quadrant_app/repositories/EwalletRepository/models/wallet_response.dart';

part 'ewallet_event.dart';
part 'ewallet_state.dart';

class EwalletBloc extends Bloc<EwalletEvent, EwalletState> {
  EwalletBloc({ required EwalletRepository ewalletRepository }) : _ewalletRepository = ewalletRepository, super(EwalletLoading()) {
    on<FetchWallet>(_onFetchWallet);
    on<FetchWalletTransaction>(_onFetchWalletTransaction);
  }

  final EwalletRepository _ewalletRepository;

  Future<void> _onFetchWallet(
    FetchWallet event,
    Emitter<EwalletState> emit,
  ) async {
    emit(EwalletLoading());
    try {
      final response = await _ewalletRepository.fetchWallet();
      await Future.delayed(const Duration(seconds: 5));
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
      final response = await _ewalletRepository.fetchWallet();
      emit(EwalletTransactionsLoaded(transactions: response!));
    } catch (_) {
      emit(EwalletError());
    }
  }
}
