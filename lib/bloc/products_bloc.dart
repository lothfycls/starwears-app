import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:starwears/bloc/authentication_bloc.dart';
import 'package:starwears/bloc/celebrity_bloc.dart';
import 'package:starwears/models/product.dart';

import '../services/products_service.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsService productsService = ProductsService();
  AuthenticationBloc authenticationBloc;
  ProductsBloc({required this.authenticationBloc}) : super(ProductsInitial()) {
    on<GetProductsByCategory>((event, emit) async {
      try {
        List<Product> products =
            await productsService.getCategoryProduct(event.categoryId);
        emit(ProductsReady(products: products));
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });
    on<GetCelebrityProducts>((event, emit) async {
      try {
        List<Product> products =
            await productsService.getCelebrityProducts(event.celebrityId);
        emit(ProductsReady(products: products));
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });
    on<GetBrandProducts>((event, emit) async {
      try {
        List<Product> products =
            await productsService.getBrandProducts(event.brandId);
        emit(ProductsReady(products: products));
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });
    on<GetTrendingProducts>((event, emit) async {
      try {
        List<Product> products = await productsService.getTrendingProducts();
        if (products.isEmpty) {
          throw Exception("No trending products yet");
        }
        emit(ProductsReady(products: products));
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });
    on<GetEndedProducts>((event, emit) async {
      try {
        List<Product> products = await productsService.getEndedProducts();
        emit(ProductsReady(products: products));
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });
    on<GetActiveProducts>((event, emit) async {
      try {
        List<Product> products = await productsService.getActiveProducts();
        emit(ProductsReady(products: products));
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });

    on<GetUserBidProducts>((event, emit) async {
      try {
        final currentId = authenticationBloc.userId;
        if (currentId != null) {
          List<Product> products =
              await productsService.getUserBidProducts(currentId);
          print(products.length.toString() + "is.lengt");
          emit(ProductsReady(products: products));
        } else {
          throw Exception("You're not logged in");
        }
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });
    on<GetUserActiveBids>((event, emit) async {
      try {
        final currentId = authenticationBloc.userId;
        if (currentId != null) {
          List<Product> products =
              await productsService.getActiveBids(currentId);
          emit(ProductsReady(products: products));
        } else {
          throw Exception("You're not logged in");
        }
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });
    on<GetUserLostBids>((event, emit) async {
      try {
        final currentId = authenticationBloc.userId;
        if (currentId != null) {
          List<Product> products = await productsService.getLostBids(currentId);
          emit(ProductsReady(products: products));
        } else {
          throw Exception("You're not logged in");
        }
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });
    on<GetUserWonBids>((event, emit) async {
      try {
        final currentId = authenticationBloc.userId;
        if (currentId != null) {
          List<Product> products = await productsService.getWonBids(currentId);
          emit(ProductsReady(products: products));
        } else {
          throw Exception("You're not logged in");
        }
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });
  }
}
