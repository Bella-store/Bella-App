part of 'all_products_cubit.dart';

abstract class AllProductsState {}

class ProductsInitial extends AllProductsState {}

class ProductsLoadingState extends AllProductsState {}

class ProductsLoadedState extends AllProductsState {
  final List<Product> products;

  ProductsLoadedState(this.products);
}

class ProductsEmptyState extends AllProductsState {}

class ProductsErrorState extends AllProductsState {
  final String message;

  ProductsErrorState(this.message);
}
