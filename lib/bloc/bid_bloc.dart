import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:starwears/services/bids_service.dart';

import '../models/bid.dart';
import 'authentication_bloc.dart';

part 'bid_event.dart';
part 'bid_state.dart';

class BidBloc extends Bloc<BidEvent, BidState> {
  BidService bidService = BidService();
  AuthenticationBloc authenticationBloc;
  BidBloc({required this.authenticationBloc}) : super(BidInitial()) {
    on<InitBid>(((event, emit) => emit(BidInitial())));
    on<AddBid>((event, emit) async {
      try {
        final currentId = authenticationBloc.userId;
        if (currentId != null) {
          await bidService.addBid(Bid(
              amount: event.amount, productId: event.productId, id: currentId));
          emit(BidAdded());
        } else {
          emit(UserNotLogged());
        }
      } catch (e) {
        emit(BidsFailed(error: e.toString().substring(10)));
      }
    });
    on<GetUserRelationShip>((event, emit) async {
      try {
        final currentId = authenticationBloc.userId;
        if (currentId != null) {
          Map<String, dynamic> data = await bidService.getUserRelationShipBid(
              event.productId, currentId);
          final String state = data["state"];
          switch (state) {
            case "never":
              emit(NeverBidded());
              break;
            case "already":
              emit(AlreadyBidded());
              break;
            case "outbidded":
              emit(OutBidded());
              break;
            case "won":
              emit(WonBid());
              break;
            default:
              emit(LostBid());
          }
        } else {
          throw Exception("You're not logged in");
        }
      } catch (e) {
        emit(BidsFailed(error: e.toString()));
      }
    });
  }
}
