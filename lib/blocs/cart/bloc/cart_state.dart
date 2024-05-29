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

  const CartLoaded({required this.cart});

  @override
  List<Object> get props => [cart];
}


class CartError extends CartState {}


