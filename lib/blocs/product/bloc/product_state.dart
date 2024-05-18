part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  
  @override
  List<Object> get props => [];
}

final class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Products>? products;

  const ProductLoaded({required this.products});

  @override
  List<Object> get props => [products!];
}

class ProductError extends ProductState {}

