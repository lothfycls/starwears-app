import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:starwears/Screens/ReviewBidscreen.dart';
import 'package:starwears/bloc/singleproduct_bloc.dart';
import 'package:starwears/widgets/BidCard.dart';
import 'package:starwears/widgets/CategoryCard.dart';

import '../widgets/BrandCard.dart';

class PlaceBidScreen extends StatefulWidget {
  final int productId;
  final int maxBid;
  final String date;
  const PlaceBidScreen(
      {Key? key,
      required this.productId,
      required this.maxBid,
      required this.date})
      : super(key: key);

  @override
  State<PlaceBidScreen> createState() => _PlaceBidScreenState();
}

class _PlaceBidScreenState extends State<PlaceBidScreen> {
  double? _bid = 0;
  final currencyFormat =
      NumberFormat.simpleCurrency(decimalDigits: 2, locale: 'fr');

  GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SingleproductBloc, SingleproductState>(
      builder: (context, state) {
        if (state is SingleProductReady) {
          return Scaffold(
              // resizeToAvoidBottomInset: false,
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
                          "Product",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                title: Text(
                  'Place your Bid',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
              ),
              body: Form(
                key: formKey,
                child: ListView(
                  children: [
                    Container(
                      height: 300,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text(
                              "€25 shipping",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              "${state.product.bidsCount} bids - ${state.product.auctionEnd}",
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) =>
                                  value!.isEmpty ? "Enter a bid value" : null,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 30),
                              controller: _controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                CurrencyTextInputFormatter(
                                    symbol: currencyFormat.currencySymbol),
                              ],
                              decoration: InputDecoration(
                                hintText: '€0.00',
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Text(
                              "Your Bid",
                              style: TextStyle(fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 10,
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
                          'Review Your Bid',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReviewBidScreen(
                                        bidAmount: double.parse(_controller.text
                                            .replaceFirst("€", "")),
                                        productId: widget.productId,
                                        maxBid: widget.maxBid,
                                        date: widget.date,
                                      )),
                            ).then((value) {
                              if (value) {
                                Navigator.pop(context);
                              }
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ));
        } else {
          return const Center(
            child: Text("You can't bid temporarily"),
          );
        }
      },
    );
  }
}

class CurrencyTextInputFormatter extends TextInputFormatter {
  final String symbol;

  CurrencyTextInputFormatter({required this.symbol});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final double? value = double.tryParse(newValue.text);

    if (value != null) {
      final currencyFormat =
          NumberFormat.currency(locale: 'en_US', symbol: "€", decimalDigits: 2);
      final formattedValue = currencyFormat.format(value);

      return TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    }

    return newValue;
  }
}
