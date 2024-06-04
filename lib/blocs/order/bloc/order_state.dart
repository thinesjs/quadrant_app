part of 'order_bloc.dart';

sealed class OrderState extends Equatable {
  const OrderState();
  
  @override
  List<Object> get props => [];
}

final class OrderInitial extends OrderState {}

class OrdersLoading extends OrderState {}

class OrderLoading extends OrderState {}

class OrdersLoaded extends OrderState {
  final List<OrdersResponseData>? orders;

  const OrdersLoaded({required this.orders});

  @override
  List<Object> get props => [orders!];
}

class OrderLoaded extends OrderState {
  final OrderResponseData order;

  const OrderLoaded({required this.order});

  @override
  List<Object> get props => [order];
}

class OrderError extends OrderState {}

