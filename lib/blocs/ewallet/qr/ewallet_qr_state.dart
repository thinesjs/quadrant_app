part of 'ewallet_qr_bloc.dart';

sealed class EwalletQrState extends Equatable {
  const EwalletQrState();
  
  @override
  List<Object> get props => [];
}

final class EwalletQrInitial extends EwalletQrState {}

class EwalletQrLoading extends EwalletQrState {}

class EwalletQrLoaded extends EwalletQrState {
  final EwalletQrResponse walletQr;

  const EwalletQrLoaded({required this.walletQr});

  @override
  List<Object> get props => [walletQr];
}

class EwalletQrValidated extends EwalletQrState {
  final EwalletQrResponse walletQr;

  const EwalletQrValidated({required this.walletQr});

  @override
  List<Object> get props => [walletQr];
}

class EwalletQrNotValidated extends EwalletQrState {
  final String errorMsg;

  const EwalletQrNotValidated({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class EwalletQrError extends EwalletQrState {}