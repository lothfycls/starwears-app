import 'package:bloc/bloc.dart';
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
          print(event.order.ownerId.toString() + "weeeeee ");
          Map<String, dynamic> order = await orderService.addOrder(event.order);
          orderId = order["id"];
          emit(OrderAdded(trackingOrder: 1));
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
          print(event.order.ownerId.toString() + "weeeeee ");
          await orderService.updateOrder(orderId!);
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
  }
}
