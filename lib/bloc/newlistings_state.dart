part of 'newlistings_bloc.dart';

@immutable
abstract class NewlistingsState {}

class NewlistingsInitial extends NewlistingsState {}

class ListingsReady extends NewlistingsState{
  final List<Listing> listings;

  ListingsReady({required this.listings});
}

class ListingsFailed extends NewlistingsState {
  final String error;
  ListingsFailed({
    required this.error,
  });
}