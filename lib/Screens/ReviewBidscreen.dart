import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/Screens/HomeScreen.dart';
import 'package:starwears/Screens/PlaceBidScreen.dart';
import 'package:starwears/Screens/ProductScreen.dart';
import 'package:starwears/bloc/bid_bloc.dart';
import 'package:starwears/bloc/products_bloc.dart';
import 'package:starwears/bloc/singleproduct_bloc.dart';
import 'package:starwears/widgets/BidCard.dart';
import 'package:starwears/widgets/CategoryCard.dart';

import '../bloc/relationship_bloc.dart';
import '../main.dart';
import '../widgets/BrandCard.dart';
import 'LoginScreen.dart';

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

  _showAlertDialog(errorMsg, context) {
    return showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text(
              'Bid adding Failed',
              style: TextStyle(color: Colors.black),
            ),
            content: Text(errorMsg),
          );
        }).then((val) {
      BlocProvider.of<BidBloc>(context).add(InitBid());

      Navigator.pop(context, false);
    });
  }

  _showSuccesDialog(context) {
    var ctx;
    showDialog(
        context: context,
        builder: (_) {
          ctx = _;
          return const AlertDialog(
            title: Text(
              'Bid added successfully',
              style: TextStyle(color: Colors.black),
            ),
          );
        });
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(ctx);
      BlocProvider.of<BidBloc>(context).add(InitBid());
      BlocProvider.of<SingleproductBloc>(context)
          .add(GetSingleProduct(productId: widget.productId));
      BlocProvider.of<RelationshipBloc>(context)
          .add(GetRelationShip(productId: widget.productId));
      Navigator.pop(context, true); // Pop third screen
    });
  }

  double? _bid = 0;
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double total = widget.bidAmount + 25;
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
                children: const <Widget>[
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
          title: const Text(
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
                                "€${widget.bidAmount}",
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
                                "€ 25",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "€ $total",
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
                        if (state is UserNotLogged) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              animType: AnimType.rightSlide,
                              btnOkColor: Colors.black,
                              title: 'Sign in Required',
                              desc: 'This action required to Sign in',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                outerNavigator.currentState!.push(
                                    MaterialPageRoute(
                                        builder: (_) => const LoginScreen()));
                              },
                            ).show();
                          });
                        }
                        if (state is BidsFailed) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            AwesomeDialog(
                                context: context,
                                dialogType: DialogType.warning,
                                animType: AnimType.rightSlide,
                                btnOkColor: Colors.black,
                                title: "Bid can't be placed",
                                desc:
                                    "You can't bid with price lower than the highest bid",
                                btnCancelOnPress: () {},
                                btnOkText: "Bid again",
                                btnOkOnPress: () {
                                  Navigator.pop(context, false);
                                }).show();
                          });
                        }

                        if (state is BidAdded) {
                          _showSuccesDialog(context);
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
