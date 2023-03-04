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
class UploadState extends ProductsState{}
class ActiveProductsFailed extends ProductsFailed{
  ActiveProductsFailed({required super.error});
}
class EndedProductsFailed extends ProductsFailed{
  EndedProductsFailed({required super.error});
}
class UserBidProductsFailed extends ProductsFailed{
  UserBidProductsFailed({required super.error});
}
class UserNotAuthenticated extends ProductsFailed{
  UserNotAuthenticated({required super.error});

}


