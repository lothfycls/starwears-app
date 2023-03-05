import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:starwears/bloc/authentication_bloc.dart';

import '../models/order.dart';
import '../services/orders_service.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrderService orderService = OrderService();
  int? orderId;
  AuthenticationBloc authenticationBloc;
  OrdersBloc({required this.authenticationBloc}) : super(OrdersInitial()) {
    on<AddOrder>((event, emit) async {
      try {
        final currentId = authenticationBloc.userId;
        if (currentId != null) {
          event.order.ownerId = currentId;
          Map<String, dynamic> order = await orderService.addOrder(event.order);
          orderId = order["id"];
          emit(OrderAdded(trackingOrder: orderId!));
        } else {
          throw Exception("You're not logged in");
        }
      } catch (e) {
        print(e.toString());
        emit(OrderFailed(error: e.toString()));
      }
    });
    on<UpdateOrder>((event, emit) async {
      try {
        final currentId = authenticationBloc.userId;
        if (currentId != null) {
          event.order.ownerId = currentId;
          await orderService.updateOrder(event.order.id);
          emit(OrderUpdated(trackingOrder: 1));
        } else {
          throw Exception("You're not logged in");
        }
      } catch (e) {
        print(e.toString());
        emit(OrderFailed(error: e.toString()));
      }
    });
    on<InitOrder>(((event, emit) => emit(OrdersInitial())));
    on<GetPendingOrders>((event, emit) async {
      emit(OrdersLoading());
      try {
        final currentId = authenticationBloc.userId;
        if (currentId != null) {
          List<Order> orders = await orderService.getPendingOrders(currentId);
          emit(OrdersReady(orders: orders));
        } else {
          throw Exception("You're not logged in");
        }
      } catch (e) {
        emit(OrdersFailed(error: e.toString()));
      }
    });
    on<GetOrder>((event, emit) async {
      emit(OrderLoading());

      try {
        final currentId = authenticationBloc.userId;
        if (currentId != null) {
          print("event");
          print(event.id);
          Order order = await orderService.getOrderDetail(event.id);
          emit(OrderDetail(order: order));
        } else {
          throw Exception("You're not logged in");
        }
      } catch (e) {
        emit(OrdersFailed(error: e.toString()));
      }
    });
    on<GetSuccessOrders>((event, emit) async {
      emit(OrdersLoading());

      try {
        final currentId = authenticationBloc.userId;
        if (currentId != null) {
          List<Order> orders = await orderService.getSuccessOrders(currentId);
          emit(OrdersReady(orders: orders));
        } else {
          throw Exception("You're not logged in");
        }
      } catch (e) {
        emit(OrdersFailed(error: e.toString()));
      }
    });
  }
}
