part of 'products_bloc.dart';

@immutable
abstract class ProductsEvent {}

class GetProductsByCategory extends ProductsEvent {
  final int categoryId;
  GetProductsByCategory({required this.categoryId});
}

class GetProductsOnSearch extends ProductsEvent {
  final String input;
  GetProductsOnSearch({required this.input});
}

class GetCelebrityProducts extends ProductsEvent {
  final int celebrityId;
  GetCelebrityProducts({required this.celebrityId});
}

class GetBrandProducts extends ProductsEvent {
  final int brandId;
  GetBrandProducts({required this.brandId});
}

class GetTrendingProducts extends ProductsEvent {}

class GetActiveProducts extends ProductsEvent {}

class GetEndedProducts extends ProductsEvent {}

class GetUserBidProducts extends ProductsEvent {}

class GetUserActiveBids extends ProductsEvent {}

class GetUserWonBids extends ProductsEvent {}

class GetUserLostBids extends ProductsEvent {}
