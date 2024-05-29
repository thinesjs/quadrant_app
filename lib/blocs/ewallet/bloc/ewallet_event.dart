part of 'ewallet_bloc.dart';

abstract class EwalletEvent extends Equatable {
  const EwalletEvent();
}

final class FetchWallet extends EwalletEvent {
  @override
  List<Object> get props => [];
}

final class FetchWalletTransaction extends EwalletEvent {
  @override
  List<Object> get props => [];
}