import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starwears/services/products_service.dart';

import '../models/product.dart';

part 'singleproduct_event.dart';
part 'singleproduct_state.dart';

class SingleproductBloc extends Bloc<SingleproductEvent, SingleproductState> {
  ProductsService productsService = ProductsService();
  SingleproductBloc() : super(SingleproductInitial()) {
    on<GetSingleProduct>((event, emit) async {
      //try {
      Product product = await productsService.getSingleProduct(event.productId);
      emit(SingleProductReady(product: product));
      //} catch (e) {
      // emit(SingleProductFailed(error: e.toString()));
      // }
    });
    // TODO: implement event handler
  }
}
