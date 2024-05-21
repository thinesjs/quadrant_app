part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

final class FetchProduct extends ProductEvent {
  @override
  List<Object> get props => [];
}

final class FetchProductByCategory extends ProductEvent {
  final String category;

  const FetchProductByCategory(this.category);

  @override
  List<Object> get props => [category];
}

final class FetchFeaturedProduct extends ProductEvent {
  @override
  List<Object> get props => [];
}
final class FetchForYouProduct extends ProductEvent {
  @override
  List<Object> get props => [];
}
final class FetchNewArrivalsProduct extends ProductEvent {
  @override
  List<Object> get props => [];
}

final class SearchProducts extends ProductEvent {
  final String query;

  const SearchProducts(this.query);

  @override
  List<Object> get props => [query];
}
