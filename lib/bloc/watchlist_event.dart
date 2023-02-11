part of 'watchlist_bloc.dart';

@immutable
abstract class WatchlistEvent {}

class GetActiveWatchList extends WatchlistEvent {}

class GetEndedWatchList extends WatchlistEvent {}

class CheckExist extends WatchlistEvent {
  final int productId;
  CheckExist({required this.productId});
}

class AddWatchList extends WatchlistEvent {
  final Product product;

  AddWatchList({required this.product});
}

class RemoveWatchList extends WatchlistEvent {
  final int productId;
  RemoveWatchList({required this.productId});
}
