part of 'bid_bloc.dart';

@immutable
abstract class BidEvent {}
class InitBid extends BidEvent{}
class GetUserRelationShip extends BidEvent {
  final int productId;

  GetUserRelationShip({required this.productId});
}
class GetHighestBid extends BidEvent{}
class AddBid extends BidEvent {
  final int amount;
  final int productId;
  AddBid({required this.amount, required this.productId});
}
