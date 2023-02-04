part of 'products_bloc.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsReady extends ProductsState {
  final List<Product> products;
  ProductsReady({
    required this.products,
  });
}

class ProductsFailed extends ProductsState {
  final String error;
  ProductsFailed({
    required this.error,
  });
}
