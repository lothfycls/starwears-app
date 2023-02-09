import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/listing.dart';
import '../services/banners_service.dart';

part 'newlistings_event.dart';
part 'newlistings_state.dart';

class NewlistingsBloc extends Bloc<NewlistingsEvent, NewlistingsState> {
   BannersService bannersService = BannersService();
  List<Listing> banners = [];
  NewlistingsBloc() : super(NewlistingsInitial()) {
  on<GetListings>((event, emit) async {
      try {
        final List<Listing> _banners = await bannersService.getNewListings();
        banners = _banners;
        emit(ListingsReady(listings: _banners));
      } catch (e) {
        emit(ListingsFailed(error: e.toString()));
      }
    });
  }
}
