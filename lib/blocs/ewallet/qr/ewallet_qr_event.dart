part of 'ewallet_qr_bloc.dart';

sealed class EwalletQrEvent extends Equatable {
  const EwalletQrEvent();

  @override
  List<Object> get props => [];
}

final class FetchWalletQr extends EwalletQrEvent {
  final String? amount;

  const FetchWalletQr([this.amount]);

  @override
  List<Object> get props => [];
}

final class ValidateWalletQr extends EwalletQrEvent {
  final String ewalletQrId;

  const ValidateWalletQr({required this.ewalletQrId});

  @override
  List<Object> get props => [];
}