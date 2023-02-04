import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starwears/bloc/celebrity_bloc.dart';
import 'package:starwears/models/product.dart';

import '../services/products_service.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsService productsService = ProductsService();
  ProductsBloc() : super(ProductsInitial()) {
    on<GetProductsByCategory>((event, emit) async{
       try {
        List<Product> products = await productsService.getCategoryProduct(event.categoryId);
        emit(ProductsReady(products: products));
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });
     on<GetCelebrityProducts>((event, emit) async{
       try {
        List<Product> products = await productsService.getCelebrityProducts(event.celebrityId);
        emit(ProductsReady(products: products));
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });
      on<GetBrandProducts>((event, emit) async{
       try {
        List<Product> products = await productsService.getBrandProducts(event.brandId);
        emit(ProductsReady(products: products));
      } catch (e) {
        emit(ProductsFailed(error: e.toString()));
      }
    });
  }
}
