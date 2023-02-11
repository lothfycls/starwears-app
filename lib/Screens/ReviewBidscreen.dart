import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/Screens/HomeScreen.dart';
import 'package:starwears/Screens/PlaceBidScreen.dart';
import 'package:starwears/Screens/ProductScreen.dart';
import 'package:starwears/bloc/bid_bloc.dart';
import 'package:starwears/widgets/BidCard.dart';
import 'package:starwears/widgets/CategoryCard.dart';

import '../bloc/relationship_bloc.dart';
import '../widgets/BrandCard.dart';

class ReviewBidScreen extends StatefulWidget {
  final double bidAmount;
  final int productId;
  final int maxBid;
  final String date;
  const ReviewBidScreen(
      {Key? key,
      required this.bidAmount,
      required this.productId,
      required this.date,
      required this.maxBid})
      : super(key: key);

  @override
  State<ReviewBidScreen> createState() => _ReviewBidScreenState();
}

class _ReviewBidScreenState extends State<ReviewBidScreen> {
  void _onWidgetDidBuild(Function callback) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callback();
    });
  }

  _showAlertDialog(errorMsg) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Bid adding Failed',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(errorMsg),
          );
        }).then((val) {
      BlocProvider.of<BidBloc>(context).add(InitBid());
    
      Navigator.pop(context);
    });
  }

  _showSuccesDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text(
              'Bid added successfully',
              style: TextStyle(color: Colors.black),
            ),
          );
        }).then((val) {
      BlocProvider.of<BidBloc>(context).add(InitBid());
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (_) => ProductScreen(
                    productId: widget.productId,
                  )),
          ((route) => false));
    });
  }

  double? _bid = 0;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final int total = widget.maxBid + 25;
    print(_bid);
    return Scaffold(
        resizeToAvoidBottomInset: true,
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
                children: <Widget>[
                  // SizedBox(width: 5,),
                  Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 15,
                  ),
                  Text(
                    "Submit",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          title: Text(
            'Review your bid',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
        ),
        body: Container(
          // margin: EdgeInsets.symmetric(horizontal: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 236, 233, 233),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Max Bid",
                                style: TextStyle(color: Color(0xff53565A)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Time Left",
                                style: TextStyle(color: Color(0xff53565A)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Postage",
                                style: TextStyle(color: Color(0xff53565A)),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Estimated Total",
                                style: TextStyle(color: Color(0xff53565A)),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 60,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "\$${widget.maxBid}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.date,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "\$ 25",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "\$ $total",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocListener<BidBloc, BidState>(
                      listener: (context, state) {
                        if (state is BidsFailed) {
                          _onWidgetDidBuild(
                              () => _showAlertDialog(state.error));
                        }
                        if (state is BidAdded) {
                          _onWidgetDidBuild(() => _showSuccesDialog());
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
                            'Confirm Bid',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            BlocProvider.of<BidBloc>(context).add(AddBid(
                                amount: widget.bidAmount.toInt(),
                                productId: widget.productId));
                            /* do something */
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
