part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductsLoaded extends ProductState {
  final List<Products>? products;

  const ProductsLoaded({required this.products});

  @override
  List<Object> get props => [products!];
}

class ProductLoaded extends ProductState {
  final Product product;

  const ProductLoaded({required this.product});

  @override
  List<Object> get props => [product];
}

class ProductError extends ProductState {}

