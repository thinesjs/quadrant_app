import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/CartRepository/cart_repository.dart';
import 'package:quadrant_app/repositories/CartRepository/models/response.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({ required CartRepository cartRepository }) : _cartRepository = cartRepository, super(CartLoading()) {
    on<FetchCart>(_onFetchProduct);
  }

  final CartRepository _cartRepository;

  Future<void> _onFetchProduct(
    FetchCart event,
    Emitter<CartState> emit,
  ) async {
    emit(CartLoading());
    try {
      final response = await _cartRepository.fetchCart();
      emit(CartLoaded(cart: response!));
    } catch (_) {
      emit(CartError());
    }
  }
}
