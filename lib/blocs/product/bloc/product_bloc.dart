import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/ProductRepository/models/response.dart';
import 'package:quadrant_app/repositories/ProductRepository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({ required ProductRepository productRepository }) : _productRepository = productRepository, super(ProductLoading()) {
    on<FetchProduct>(_onGetProducts);
  }

  final ProductRepository _productRepository;

  Future<void> _onGetProducts(
    FetchProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _productRepository.fetchProducts();
      emit(ProductLoaded(products: response));
    } catch (_) {
      emit(ProductError());
    }
  }
}
