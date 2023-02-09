import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:starwears/Screens/HomeScreen.dart';
import 'package:starwears/bloc/orders_bloc.dart';
import 'package:http/http.dart' as http;
import '../models/order.dart';

class OrderScreen extends StatefulWidget {
  final int productId;
  final int ownerId;
  final int shippingCost;
  final int total;
  const OrderScreen(
      {Key? key,
      required this.productId,
      required this.ownerId,
      required this.shippingCost,
      required this.total})
      : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController addresseController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  Map<String, dynamic>? paymentIntent;
  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          leading: TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.black, fontSize: 10),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Confirm Order",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: "Your name"),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter a name" : null),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(hintText: "Your phone"),
                      validator: (value) => value!.isEmpty
                          ? "Please enter a phone number"
                          : null),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: addresseController,
                      decoration: const InputDecoration(
                          hintText: "Your shipping address"),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter an address" : null),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: commentController,
                    decoration: const InputDecoration(hintText: "Comment"),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocListener<OrdersBloc, OrdersState>(
                    listener: (context, state) {
                      if (state is OrderAdded) {
                        print(widget.total);
                        _onWidgetDidBuild(() async {
                          try {
                            await makePayment("${widget.total}");
                          } catch (e) {
                            print("Exception stripe");
                          }
                        });
                        BlocProvider.of<OrdersBloc>(context).add(InitOrder());
                      }
                      if (state is OrderFailed) {
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                  content: Text("Order already exists"),
                                )).then((value) {
                                                          BlocProvider.of<OrdersBloc>(context).add(InitOrder());

                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Container(
                        height: 45,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            color: Colors.black,
                            child: Text(
                              'Confirm order',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<OrdersBloc>(context).add(
                                    AddOrder(
                                        order: Order(
                                            clientComment:
                                                commentController.text == ""
                                                    ? "No comments"
                                                    : commentController.text,
                                            name: nameController.text,
                                            ownerId: widget.ownerId,
                                            paymentWay: "CARD",
                                            phone: phoneController.text,
                                            productId: widget.productId,
                                            shippingAdress:
                                                addresseController.text,
                                            shippingCost: widget.shippingCost,
                                            state: "PENDING",
                                            total: widget.total)));
                              }
                              //await makePayment(prod.lastPrice.toString());
                            })),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount.toString(), 'USD');
      //Payment Sheet
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'Adnan'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
      BlocProvider.of<OrdersBloc>(context).add(UpdateOrder(
          order: Order(
              clientComment: commentController.text == ""
                  ? "No comments"
                  : commentController.text,
              name: nameController.text,
              ownerId: widget.ownerId,
              paymentWay: "CARD",
              phone: phoneController.text,
              productId: widget.productId,
              shippingAdress: addresseController.text,
              shippingCost: widget.shippingCost,
              state: "PAID",
              total: widget.total)));
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => HomeScreen()), (route) => false);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
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
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntent = null;
      }).onError((error, stackTrace) {
        print('Error is:--->$error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Error is:---> $e');
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    } catch (e) {
      print('$e');
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
      print('Payment Intent Body->>> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      // ignore: avoid_print
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount)) * 100;
    return calculatedAmout.toString();
  }
}
