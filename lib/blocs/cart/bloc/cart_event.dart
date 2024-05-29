part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

final class FetchCart extends CartEvent {
  @override
  List<Object> get props => [];
}

final class FetchProductIsInCart extends CartEvent {
  final String productId;

  const FetchProductIsInCart(this.productId);

  @override
  List<Object> get props => [productId];
}

class AddProductToCart extends CartEvent {
  final String productId;
  final bool refreshStatus;

  const AddProductToCart({required this.productId, this.refreshStatus = false});

  @override
  List<Object> get props => [productId, refreshStatus];
}

class RemoveProductFromCart extends CartEvent {
  final String productId;
  final bool refreshStatus;

  const RemoveProductFromCart({required this.productId, this.refreshStatus = false});

  @override
  List<Object> get props => [productId, refreshStatus];
}

final class CartCheckout extends CartEvent {
  @override
  List<Object> get props => [];
}