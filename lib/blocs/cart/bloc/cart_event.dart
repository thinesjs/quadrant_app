part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

final class FetchCart extends CartEvent {
  @override
  List<Object> get props => [];
}