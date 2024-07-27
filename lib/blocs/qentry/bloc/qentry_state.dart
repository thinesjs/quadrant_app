part of 'qentry_bloc.dart';

sealed class QentryState extends Equatable {
  const QentryState();
  
  @override
  List<Object> get props => [];
}

final class QentryInitial extends QentryState {}

class QentryMessageReceived extends QentryState {
  final dynamic data;
  const QentryMessageReceived(this.data);
}

class QentryVerified extends QentryState {}