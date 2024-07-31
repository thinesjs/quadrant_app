import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/OrderRepository/models/order_response.dart';
import 'package:quadrant_app/repositories/OrderRepository/models/orders_response.dart';
import 'package:quadrant_app/repositories/OrderRepository/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc({ required OrderRepository orderRepository }) : _orderRepository = orderRepository, super(OrderInitial()) {
    on<FetchOrders>(_onFetchOrders);
    on<FetchOrder>(_onFetchOrder);
  }

  final OrderRepository _orderRepository;

  Future<void> _onFetchOrders(
    FetchOrders event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    try {
      final response = await _orderRepository.fetchOrders();
      emit(OrdersLoaded(orders: response));
    } catch (_) {
      emit(OrderError());
    }
  }

  Future<void> _onFetchOrder(
    FetchOrder event,
    Emitter<OrderState> emit,
  ) async {
    emit(OrderLoading());
    try {
      final response = await _orderRepository.fetchOrder(event.orderId);
      emit(OrderLoaded(order: response!));
    } catch (_) {
      emit(OrderError());
    }
  }
}