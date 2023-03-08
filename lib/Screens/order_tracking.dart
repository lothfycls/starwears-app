import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/widgets/custom_stepper.dart';
import 'package:status_change/status_change.dart';

import '../bloc/orders_bloc.dart';

class OrderTracking extends StatefulWidget {
  final int orderId;
  const OrderTracking({Key? key, required this.orderId}) : super(key: key);

  @override
  State<OrderTracking> createState() => _OrderTrackingState();
}

class _OrderTrackingState extends State<OrderTracking> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<OrdersBloc>(context).add(GetOrder(id: widget.orderId));
  }

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
                Navigator.of(context).pop();
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
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          color: const Color(0xffF6F6F6),
                          margin: const EdgeInsets.only(bottom: 10, top: 10),
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          state.order.product!.images[0]),
                                      fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Item is on its way to you",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.clip,
                                  ),
                                  Text(
                                      "Excpected delivery date:${state.order.deliveryDate}"),
                                  TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.all(0),
                                      ),
                                      child: Text("Track package")),
                                ],
                              ),
                            ],
                          ),
                        ),
                        OrderInfos(
                            creationDate: state.order.creationDate!,
                            orderNumber: state.order.orderNumber!,
                            total: state.order.total),
                        Text(
                          "Delivery info",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomStepper(currentIndex: 0),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Tracking Details",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Container(
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
                                        "Number",
                                        style:
                                            TextStyle(color: Color(0xff53565A)),
                                      ),
                                      SizedBox(
                                        width: 62,
                                      ),
                                      Text(
                                        "0e5ag5ae5g5adg2d1gaeg1",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 45,
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: 30),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            color: Colors.black,
                            child: Text(
                              'Track Order',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(
                          height: 20,
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
