part of 'orders_bloc.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrderAdded extends OrdersState {
  final int trackingOrder;

  OrderAdded({required this.trackingOrder});
}

class OrderUpdated extends OrdersState {
  final int trackingOrder;

  OrderUpdated({required this.trackingOrder});
}

class OrderFailed extends OrdersState {
  final String error;

  OrderFailed({required this.error});
}
