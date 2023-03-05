import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:starwears/Screens/HomeScreen.dart';
import 'package:starwears/Screens/pending_order.dart';
import 'package:starwears/bloc/orders_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:starwears/bloc/singleproduct_bloc.dart';
import '../bloc/relationship_bloc.dart';
import '../models/order.dart';

class OrderScreen extends StatefulWidget {
  final int productId;
  final int ownerId;
  final int shippingCost;
  final double total;
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
  TextEditingController cityController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey();
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
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: "Postal Code",
                      ),
                      validator: (value) =>
                          value!.isEmpty ? "Please enter an address" : null),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: cityController,
                      decoration: const InputDecoration(hintText: "City"),
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
                        BlocProvider.of<OrdersBloc>(context).add(InitOrder());
                        _onWidgetDidBuild(() async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    PendingOrder(orderId: state.trackingOrder)),
                          ).then((value) {
                            BlocProvider.of<SingleproductBloc>(context).add(
                                GetSingleProduct(productId: widget.productId));
                            BlocProvider.of<RelationshipBloc>(context).add(
                                GetRelationShip(productId: widget.productId));
                            Navigator.pop(context);
                          });
                        });
                      }
                      if (state is OrderFailed) {
                        showDialog(
                            context: context,
                            builder: (_) => const AlertDialog(
                                  content: Text("Order already exists"),
                                )).then((value) {
                          BlocProvider.of<OrdersBloc>(context).add(InitOrder());
                           BlocProvider.of<SingleproductBloc>(context).add(
                                GetSingleProduct(productId: widget.productId));
                            BlocProvider.of<RelationshipBloc>(context).add(
                                GetRelationShip(productId: widget.productId));
                          Navigator.pop(context);
                        });
                      }
                    },
                    child: Container(
                        height: 45,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            color: Colors.black,
                            child: const Text(
                              'Confirm order',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                ///id added doesn't matter, it will be created after
                                BlocProvider.of<OrdersBloc>(context).add(
                                    AddOrder(
                                        order: Order(
                                            id: -20,
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
                                                addresseController.text +
                                                    ' ' +
                                                    cityController.text,
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
}
