part of 'singleproduct_bloc.dart';

@immutable
abstract class SingleproductEvent {}

class GetSingleProduct extends SingleproductEvent {
  final int productId;
  GetSingleProduct({required this.productId});
}
