part of 'fcm_bloc.dart';

sealed class FcmState extends Equatable {
  const FcmState();
  
  @override
  List<Object> get props => [];
}

final class FcmInitial extends FcmState {}

class FcmLoading extends FcmState {}

class FcmTokenStatusLoaded extends FcmState {
  final bool status;

  const FcmTokenStatusLoaded({required this.status});

  @override
  List<Object> get props => [status];
}

class FcmError extends FcmState {}