part of 'ewallet_bloc.dart';

sealed class EwalletState extends Equatable {
  const EwalletState();
  
  @override
  List<Object> get props => [];
}

final class EwalletInitial extends EwalletState {}

class EwalletLoading extends EwalletState {}

class EwalletLoaded extends EwalletState {
  final Data wallet;

  const EwalletLoaded({required this.wallet});

  @override
  List<Object> get props => [wallet];
}

class EwalletTransactionsLoaded extends EwalletState {
  final Data transactions;

  const EwalletTransactionsLoaded({required this.transactions});

  @override
  List<Object> get props => [transactions];
}


class EwalletError extends EwalletState {}



