import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starwears/services/brands_service.dart';

import '../models/brand.dart';

part 'brand_event.dart';
part 'brand_state.dart';

class BrandBloc extends Bloc<BrandEvent, BrandState> {
  BrandService brandService = BrandService();
  List<Brand> currentBrands = [];
  BrandBloc() : super(BrandInitial()) {
    on<GetBrands>((event, emit) async {
      try {
        List<Brand> brands = await brandService.getBrands();
        currentBrands = brands;
        emit(BrandsReady(brands: brands));
      } catch (e) {
        emit(BrandsFailed(error: e.toString()));
      }
    });
  }
}
