import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quadrant_app/repositories/ProductRepository/models/response.dart';
import 'package:quadrant_app/repositories/ProductRepository/models/singleResponse.dart';
import 'package:quadrant_app/repositories/ProductRepository/product_repository.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({ required ProductRepository productRepository }) : _productRepository = productRepository, super(ProductLoading()) {
    on<FetchProducts>(_onFetchProducts);
    on<FetchProduct>(_onFetchProduct);
    on<FetchProductByCategory>(_onFetchProductsByCategory);
    on<FetchFeaturedProduct>(_onFetchFeaturedProducts);
    on<FetchForYouProduct>(_onFetchForYouProducts);
    on<FetchNewArrivalsProduct>(_onFetchNewArrivalsProducts);
    on<SearchProducts>(_onSearchProducts);
  }

  final ProductRepository _productRepository;

  Future<void> _onFetchProducts(
    FetchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _productRepository.fetchProducts();
      emit(ProductsLoaded(products: response));
    } catch (_) {
      emit(ProductError());
    }
  }

  Future<void> _onFetchProductsByCategory(
    FetchProductByCategory event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _productRepository.fetchProductsByCategory(event.category);
      emit(ProductsLoaded(products: response));
    } catch (_) {
      emit(ProductError());
    }
  }

  Future<void> _onFetchProduct(
    FetchProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _productRepository.fetchProduct(event.productId);
      emit(ProductLoaded(product: response!));
    } catch (_) {
      emit(ProductError());
    }
  }

  Future<void> _onFetchFeaturedProducts(
    FetchFeaturedProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _productRepository.fetchFeaturedProducts();
      emit(ProductsLoaded(products: response));
    } catch (_) {
      emit(ProductError());
    }
  }

  Future<void> _onFetchForYouProducts(
    FetchForYouProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _productRepository.fetchForYouProducts();
      emit(ProductsLoaded(products: response));
    } catch (_) {
      emit(ProductError());
    }
  }

  Future<void> _onFetchNewArrivalsProducts(
    FetchNewArrivalsProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _productRepository.fetchNewArrivalProducts();
      emit(ProductsLoaded(products: response));
    } catch (_) {
      emit(ProductError());
    }
  }

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final response = await _productRepository.searchProduct(query: event.query);
      emit(ProductsLoaded(products: response));
    } catch (_) {
      emit(ProductError());
    }
  }
}
