import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starwears/Screens/WatchLIstScreen.dart';
import 'package:starwears/services/products_service.dart';

import '../models/product.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  ProductsService productsService = ProductsService();
  WatchlistBloc() : super(WatchlistInitial()) {
    on<AddWatchList>((event, emit) async {
      await productsService.addToWatchList(event.product);
      emit(WatchListExist());
    });
    on<GetActiveWatchList>((event, emit) async {
      List<Product> products = await productsService.getWatchListItems();
      emit(WatchListReady(
          products:
              products.where((element) => element.state == "Active").toList()));
    });
    on<GetEndedWatchList>((event, emit) async {
      List<Product> products = await productsService.getWatchListItems();
      final newList = products
          .where((element) => element.state as String == "Sold")
          .toList();
      print(newList.length);
      emit(WatchListReady(products: newList));
    });
    on<RemoveWatchList>((event, emit) async {
      await productsService.removeFromWatchList(event.productId);
      emit(WatchListAbsent());
    });
    on<CheckExist>((event, emit) async {
      bool exists = await productsService.watchListExist(event.productId);
      if (exists) {
        emit(WatchListExist());
      } else {
        emit(WatchListAbsent());
      }
    });
  }
}
