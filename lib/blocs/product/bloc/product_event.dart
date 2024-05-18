part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

final class FetchProduct extends ProductEvent {
  @override
  List<Object> get props => [];
}
