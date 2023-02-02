part of 'brand_bloc.dart';

@immutable
abstract class BrandState {}

class BrandInitial extends BrandState {}

class BrandsReady extends BrandState {
  final List<Brand> brands;
  BrandsReady({
    required this.brands,
  });
}

class BrandsFailed extends BrandState {
  final String error;
  BrandsFailed({
    required this.error,
  });
}
