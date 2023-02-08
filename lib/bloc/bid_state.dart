part of 'bid_bloc.dart';

@immutable
abstract class BidState {}

class BidInitial extends BidState {}

class BidsReady extends BidState {
  final List<Bid> bids;
  BidsReady({required this.bids});
}


class BidAdded extends BidState {}

class NeverBidded extends BidState {}

class OutBidded extends BidState {}

class AlreadyBidded extends BidState {}

class WonBid extends BidState {}

class LostBid extends BidState {}

class BidsFailed extends BidState {
  final String error;
  BidsFailed({
    required this.error,
  });
}
