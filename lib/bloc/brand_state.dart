part of 'brand_bloc.dart';

@immutable
abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandsReady extends BrandState {
  List<Brand> brands;
  BrandsReady({
    required this.brands,
  });
}

class BrandsFailed extends BrandState {
  String error;
  BrandsFailed({
    required this.error,
  });
}
