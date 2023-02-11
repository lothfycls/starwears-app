part of 'orders_bloc.dart';

@immutable
abstract class OrdersEvent {}

class AddOrder extends OrdersEvent {
  final Order order;

  AddOrder({required this.order});
}

class UpdateOrder extends OrdersEvent {
  final Order order;

  UpdateOrder({required this.order});
}

class InitOrder extends OrdersEvent{}
class GetPendingOrders extends OrdersEvent{}
class GetSuccessOrders extends OrdersEvent{}