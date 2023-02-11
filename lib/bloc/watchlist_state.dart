part of 'watchlist_bloc.dart';

@immutable
abstract class WatchlistState {}

class WatchlistInitial extends WatchlistState {}
class WatchListReady extends WatchlistState {
  final List<Product> products;
  WatchListReady({
    required this.products,
  });
}
class WatchListExist extends WatchlistState{}
class WatchListAbsent extends WatchlistState{}