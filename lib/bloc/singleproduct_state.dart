part of 'singleproduct_bloc.dart';

@immutable
abstract class SingleproductState {}

class SingleproductInitial extends SingleproductState {}

class SingleProductReady extends SingleproductState {
  final Product product;
  SingleProductReady({required this.product});
}

class SingleProductFailed extends SingleproductState {
  final String error;
  SingleProductFailed({required this.error});
}
