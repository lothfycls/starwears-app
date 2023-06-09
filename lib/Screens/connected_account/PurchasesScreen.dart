import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/Screens/order_tracking.dart';
import 'package:starwears/Screens/pending_order.dart';
import 'package:starwears/bloc/orders_bloc.dart';

import '../../bloc/authentication_bloc.dart';
import '../LoginScreen.dart';
import '../Notifications.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({Key? key}) : super(key: key);

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  bool _value = false;
  @override
  void initState() {
    super.initState();
    ordersBloc = BlocProvider.of<OrdersBloc>(context);
    BlocProvider.of<OrdersBloc>(context).add(GetPendingOrders());
  }

  void _onChanged(bool value) {
    if (value == true) {
      BlocProvider.of<OrdersBloc>(context).add(GetSuccessOrders());
    }
    if (value == false) {
      BlocProvider.of<OrdersBloc>(context).add(GetPendingOrders());
    }
    setState(() {
      _value = value;
    });
  }

  late OrdersBloc ordersBloc;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                toolbarHeight: 40,
                centerTitle: true,
                title: Text(
                  'Orders',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                leading: Container(
                    padding: EdgeInsets.only(left: 10),
                    child: InkWell(
                        onTap: (() {
                          Navigator.of(context).pop();
                        }),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 15,
                            ),
                          ],
                        ))),
                actions: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(right: 15),
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: Colors.black,
                      size: 25,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const NotificationsScreen()));
                      // Perform some action when the button is pressed
                    },
                  ),
                ],
              ),
              body: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: <Widget>[
                            Container(
                              // width: 100,
                              child: FlatButton(
                                onPressed: () => _onChanged(false),
                                child: Text("Pending"),
                              ),
                            ),
                            _value == false
                                ? Positioned(
                                    bottom: 0,
                                    left: 15,
                                    right: 0,
                                    child: Container(
                                      height: 2.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                onPressed: () => _onChanged(true),
                                child: Text("Paid"),
                              ),
                            ),
                            _value == true
                                ? Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 2.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<OrdersBloc, OrdersState>(
                    builder: (context, state) {
                      if (state is OrdersReady) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.orders.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  if (state.orders[index].state != "PAID") {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => PendingOrder(
                                                  orderId:
                                                      state.orders[index].id,
                                                ))).then((value) async {
                                      ordersBloc.add(GetPendingOrders());
                                    });
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => OrderTracking(
                                                  orderId:
                                                      state.orders[index].id,
                                                ))).then((value) {
                                      ordersBloc.add(GetSuccessOrders());
                                    });
                                  }
                                },
                                child: Card(
                                  color: const Color(0xffF6F6F6),
                                  margin: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(state
                                                  .orders[index]
                                                  .product!
                                                  .images[0]),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(
                                              state.orders[index].product!
                                                  .description,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                "€${state.orders[index].product!.lastPrice}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 23,
                                                  color: Color(0xffEB9B00),
                                                ),
                                              ),
                                              SizedBox(width: 40),
                                              Text(state.orders[index].product!
                                                      .bidsCount
                                                      .toString() +
                                                  " Bids"),
                                              SizedBox(width: 15),
                                              Text(state.orders[index].product!
                                                  .auctionEnd),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else if (state is OrdersLoading) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        );
                      } else {
                        return const Center(
                          child: Text("No Orders items"),
                        );
                      }
                    },
                  )
                ],
              ));
        } else {
          return SafeArea(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("You have to login in order to see this page"),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 45,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            color: Colors.black,
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const LoginScreen()),
                                  (route) => false);
                              //await makePayment(prod.lastPrice.toString());
                            })),
                  ]),
            ),
          );
        }
      },
    );
  }
}
