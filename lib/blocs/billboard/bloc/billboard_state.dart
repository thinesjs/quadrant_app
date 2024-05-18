part of 'billboard_bloc.dart';

abstract class BillboardState extends Equatable {
  const BillboardState();
  
  @override
  List<Object> get props => [];
}

final class BillboardInitial extends BillboardState {}

class BillboardLoading extends BillboardState {}

class BillboardLoaded extends BillboardState {
  final List<Message>? billboards;

  const BillboardLoaded({required this.billboards});

  @override
  List<Object> get props => [billboards!];
}

class BillboardError extends BillboardState {}
