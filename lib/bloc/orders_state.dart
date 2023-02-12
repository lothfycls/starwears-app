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

class OrdersReady extends OrdersState {
  final List<Order> orders;
  OrdersReady({
    required this.orders,
  });
}

class OrderDetail extends OrdersState {
  final Order order;
  OrderDetail({required this.order});
}

class OrderFailed extends OrdersState {
  final String error;

  OrderFailed({required this.error});
}

class OrdersFailed extends OrdersState {
  final String error;

  OrdersFailed({required this.error});
}
