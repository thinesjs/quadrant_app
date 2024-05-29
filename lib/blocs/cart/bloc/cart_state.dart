part of 'cart_bloc.dart';

sealed class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Items> cart;
  final Meta meta;

  const CartLoaded({required this.cart, required this.meta});

  @override
  List<Object> get props => [cart, meta];
}
class CartCheckoutCallback extends CartState {
  final CartCheckoutResponse cartCheckout;

  const CartCheckoutCallback({required this.cartCheckout});

  @override
  List<Object> get props => [cartCheckout];
}

class ProductIsInCartLoaded extends CartState {
  final PICR.Data? data;

  const ProductIsInCartLoaded({this.data});

  @override
  List<Object> get props => [data!];
}


class CartError extends CartState {}


