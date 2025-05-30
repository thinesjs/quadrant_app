import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/CartRepository/cart_repository.dart';
import 'package:quadrant_app/repositories/CartRepository/models/cartcheckout_response.dart';
import 'package:quadrant_app/repositories/CartRepository/models/response.dart';
import 'package:quadrant_app/repositories/CartRepository/models/productincart_response.dart' as PICR;
import 'package:quadrant_app/utils/enums/cart_type.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({ required CartRepository cartRepository }) : _cartRepository = cartRepository, super(CartLoading()) {
    on<FetchCart>(_onFetchCart);
    on<FetchProductIsInCart>(_onFetchProductIsInCart);
    on<AddProductToCart>(_onAddProductToCart);
    on<AddProductQtyFromCart>(_onAddProductQtyFromCart);
    on<RemoveProductQtyFromCart>(_onRemoveProductQtyFromCart);
    on<CartCheckout>(_onCartCheckout);
  }

  final CartRepository _cartRepository;

  Future<void> _onFetchCart(
    FetchCart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final response = await _cartRepository.fetchCart(event.cartType);
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
      final response = await _cartRepository.checkProductInCart(event.productId, event.cartType);
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
      final response = await _cartRepository.addProductToCart(event.productId, event.qty, event.cartType);
      if(event.refreshStatus){
        add(FetchProductIsInCart(event.productId, event.cartType));
      }else{
        emit(CartLoaded(cart: response.data!.items!, meta: response.meta!));
      }
    } catch (e) {
      emit(CartError());
    }
  }

   Future<void> _onAddProductQtyFromCart(
    AddProductQtyFromCart event, 
    Emitter<CartState> emit) async {
    try {
      final response = await _cartRepository.addProductToCart(event.productId, event.qty, event.cartType);
      if(event.refreshStatus){
        add(FetchProductIsInCart(event.productId, event.cartType));
      }else{
        emit(CartLoaded(cart: response.data!.items!, meta: response.meta!));
      }
    } catch (e) {
      emit(CartError());
    }
  }


  Future<void> _onRemoveProductQtyFromCart(
    RemoveProductQtyFromCart event, 
    Emitter<CartState> emit) async {
    try {
      final response = await _cartRepository.removeProductToCart(event.productId, event.qty, event.cartType);
      if(event.refreshStatus){
        add(FetchProductIsInCart(event.productId, event.cartType));
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
      final response = await _cartRepository.requestCheckout(event.paymentMethodId, event.cartType);
      // add(CartLoaded(event.productId));
      emit(CartCheckoutCallback(cartCheckout: response));
      // emit(currentState);
    } catch (_) {
      emit(CartError());
    }
  }
}
