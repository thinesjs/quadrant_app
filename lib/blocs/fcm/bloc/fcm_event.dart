part of 'fcm_bloc.dart';

sealed class FcmEvent extends Equatable {
  const FcmEvent();

  @override
  List<Object> get props => [];
}

final class FetchFcmStatus extends FcmEvent {
  const FetchFcmStatus();

  @override
  List<Object> get props => [];
}

final class UpdateFcmTokenStatus extends FcmEvent {
  final bool currentStatus;

  const UpdateFcmTokenStatus({required this.currentStatus});

  @override
  List<Object> get props => [currentStatus];
}
