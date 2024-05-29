import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/CartRepository/cart_repository.dart';
import 'package:quadrant_app/repositories/CartRepository/models/cartcheckout_response.dart';
import 'package:quadrant_app/repositories/CartRepository/models/response.dart';
import 'package:quadrant_app/repositories/CartRepository/models/productincart_response.dart' as PICR;

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({ required CartRepository cartRepository }) : _cartRepository = cartRepository, super(CartLoading()) {
    on<FetchCart>(_onFetchProduct);
    on<FetchProductIsInCart>(_onFetchProductIsInCart);
    on<AddProductToCart>(_onAddProductToCart);
    on<RemoveProductFromCart>(_onRemoveProductFromCart);
    on<CartCheckout>(_onCartCheckout);
  }

  final CartRepository _cartRepository;

  Future<void> _onFetchProduct(
    FetchCart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final response = await _cartRepository.fetchCart();
      emit(CartLoaded(cart: response.data!.items!, meta: response.meta!));
    } catch (_) {
      emit(CartError());
    }
  }

  Future<void> _onFetchProductIsInCart(
    FetchProductIsInCart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final response = await _cartRepository.checkProductInCart(event.productId);
      if(response == null){
        emit(const ProductIsInCartLoaded(data: null));
        return;
      }
      emit(ProductIsInCartLoaded(data: response));
    } catch (_) {
      emit(CartError());
    }
  }

  Future<void> _onAddProductToCart(
    AddProductToCart event, 
    Emitter<CartState> emit) async {
    try {
      final response = await _cartRepository.addProductToCart(event.productId);
      if(event.refreshStatus){
        add(FetchProductIsInCart(event.productId));
      }else{
        emit(CartLoaded(cart: response.data!.items!, meta: response.meta!));
      }
    } catch (e) {
      emit(CartError());
    }
  }

  Future<void> _onRemoveProductFromCart(
    RemoveProductFromCart event, 
    Emitter<CartState> emit) async {
    try {
      final response = await _cartRepository.removeProductToCart(event.productId);
      if(event.refreshStatus){
        add(FetchProductIsInCart(event.productId));
      }else{
        emit(CartLoaded(cart: response.data!.items!, meta: response.meta!));
      }
    } catch (e) {
      emit(CartError());
    }
  }

  Future<void> _onCartCheckout(
    CartCheckout event,
    Emitter<CartState> emit,
  ) async {
    final currentState = state;
    emit(CartLoading());
    try {
      final response = await _cartRepository.requestCheckout();
      emit(CartCheckoutCallback(cartCheckout: response));
      // emit(currentState);
    } catch (_) {
      emit(CartError());
    }
  }
}
