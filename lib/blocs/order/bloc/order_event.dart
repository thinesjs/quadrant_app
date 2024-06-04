part of 'order_bloc.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
}

final class FetchOrders extends OrderEvent {
  @override
  List<Object> get props => [];
}

final class FetchOrder extends OrderEvent {
  final String orderId;

  const FetchOrder(this.orderId);

  @override
  List<Object> get props => [orderId];
}