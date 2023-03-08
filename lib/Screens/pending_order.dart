import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:starwears/Screens/connected_account/PurchasesScreen.dart';
import '../bloc/orders_bloc.dart';
import 'package:http/http.dart' as http;

import '../models/order.dart';

class PendingOrder extends StatefulWidget {
  final int orderId;
  const PendingOrder({Key? key, required this.orderId}) : super(key: key);

  @override
  State<PendingOrder> createState() => _PendingOrderState();
}

class _PendingOrderState extends State<PendingOrder> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<OrdersBloc>(context).add(GetOrder(id: widget.orderId));
  }

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100,
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 40,
          centerTitle: true,
          leading: Container(
            // color: Colors.red,
            padding: EdgeInsets.only(left: 10),
            // width: 100,
            // width: 200,
            child: InkWell(
              onTap: (() {
                Navigator.pop(context, true);
              }),
              child: Row(
                // mainAxisAlignment: M,
                children: const <Widget>[
                  // SizedBox(width: 5,),
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                  Text(
                    "Orders",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          title: const Text(
            'Order Details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 15),
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                // Perform some action when the button is pressed
              },
            ),
          ],
        ),
        body: BlocBuilder<OrdersBloc, OrdersState>(
          builder: (context, state) {
            if (state is OrderDetail) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: const Color(0xffF6F6F6),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(
                                    state.order.product!.images[0]),
                                fit: BoxFit.cover),
                          ),
                        ),
                        OrderInfos(
                            creationDate: state.order.creationDate!,
                            orderNumber: state.order.id,
                            total: state.order.total),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 45,
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 30),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            color: Colors.black,
                            child: const Text(
                              'Place Payment',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              try {
                                await makePayment(
                                    "${state.order.total}", state.order);
                              } catch (e) {
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          //margin: EdgeInsets.symmetric(horizontal: 30),
                          child: const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Delivery Address",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.order.shippingAdress,
                          style: TextStyle(color: Color(0xff53565A)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          //margin: EdgeInsets.symmetric(horizontal: 30),
                          child: Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Payment Info",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          state.order.paymentWay,
                          style: TextStyle(
                              color: Color.fromARGB(255, 184, 187, 190)),
                        ),
                      ]));
            } else if (state is OrderLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              );
            } else {
              return const Center(
                child: Text("No order details"),
              );
            }
          },
        ));
  }

  Future<void> makePayment(String amount, Order order) async {
    try {
      paymentIntent = await createPaymentIntent(amount.toString(), 'USD');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {});
      displayPaymentSheet(order);
    } catch (e, s) {
    }
  }

  displayPaymentSheet(Order order) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                ));
        BlocProvider.of<OrdersBloc>(context).add(UpdateOrder(
            order: Order(
                id: order.id,
                clientComment: order.clientComment,
                name: order.name,
                ownerId: order.ownerId,
                paymentWay: "CARD",
                phone: order.phone,
                productId: order.productId,
                shippingAdress: order.shippingAdress,
                shippingCost: order.shippingCost,
                state: "PAID",
                total: order.total)));
        Navigator.pop(context, true);
        paymentIntent = null;
      }).onError((error, stackTrace) {
        const AlertDialog(
          content: Text("Payment couldn't be proceeded, Please try again"),
        );
      });
    } on StripeException catch (e) {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization':
              'Bearer sk_test_51MYvFJHU6zFyNPkf2IlvvSSTXCKE9lBP4f4i6LpxcrWUmqPB7mVloGOMqfDP46fcRk8UWVjkhhA49GngcgVC1vBU00k8tejYZK',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );
      // ignore: avoid_print
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print

    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (double.parse(amount).toInt()) * 100;
    return calculatedAmout.toString();
  }
}

class OrderInfos extends StatelessWidget {
  final String creationDate;
  final int orderNumber;
  final double total;
  const OrderInfos({
    Key? key,
    required this.creationDate,
    required this.orderNumber,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 15, top: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Time placed",
                    style: TextStyle(color: Color(0xff53565A)),
                  ),
                  SizedBox(
                    width: 62,
                  ),
                  Text(
                    creationDate,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Order Number",
                    style: TextStyle(color: Color(0xff53565A)),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text(
                    "$orderNumber",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    "Total",
                    style: TextStyle(color: Color(0xff53565A)),
                  ),
                  SizedBox(
                    width: 46,
                  ),
                  Text(
                    "€ $total",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
