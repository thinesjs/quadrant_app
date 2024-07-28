part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

final class FetchCart extends CartEvent {
  final CartType cartType;

  const FetchCart(this.cartType);
  
  @override
  List<Object> get props => [cartType];
}

final class FetchProductIsInCart extends CartEvent {
  final String productId;
  final CartType cartType;

  const FetchProductIsInCart(this.productId, this.cartType);

  @override
  List<Object> get props => [productId];
}

class AddProductToCart extends CartEvent {
  final String productId;
  final int qty;
  final CartType cartType;
  final bool refreshStatus;

  const AddProductToCart({required this.productId, this.qty = 1, this.cartType = CartType.ONLINE, this.refreshStatus = false});

  @override
  List<Object> get props => [productId, refreshStatus];
}

class AddProductQtyFromCart extends CartEvent {
  final String productId;
  final int? qty;
  final CartType cartType;
  final bool refreshStatus;

  const AddProductQtyFromCart({required this.productId, this.qty, this.cartType = CartType.ONLINE, this.refreshStatus = false});

  @override
  List<Object> get props => [productId, refreshStatus];
}

class RemoveProductQtyFromCart extends CartEvent {
  final String productId;
  final int? qty;
  final CartType cartType;
  final bool refreshStatus;

  const RemoveProductQtyFromCart({required this.productId, this.qty, this.cartType = CartType.ONLINE, this.refreshStatus = false});

  @override
  List<Object> get props => [productId, refreshStatus];
}

final class CartCheckout extends CartEvent {
  final String paymentMethodId;
  final CartType cartType;

  const CartCheckout({required this.paymentMethodId, this.cartType = CartType.ONLINE});

  @override
  List<Object> get props => [paymentMethodId];
}