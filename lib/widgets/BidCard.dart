import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:readmore/readmore.dart';
import 'package:starwears/Screens/PlaceBidScreen.dart';
import 'package:starwears/Screens/ProductDetailsScreen.dart';
import 'package:starwears/Screens/ProductScreen.dart';
import 'package:starwears/bloc/bid_bloc.dart';
import 'package:starwears/utils/utils.dart';

import '../models/bid.dart';
import '../models/product.dart';

class BidCard extends StatefulWidget {
  final String name;
  final String description;
  final String owner;
  final String lastBidUser;
  final double lastPrice;
  final String state;
  final String imagePath;
  final Product product;
  const BidCard({
    Key? key,
    required this.name,
    required this.description,
    required this.owner,
    required this.product,
    required this.lastBidUser,
    required this.lastPrice,
    required this.state,
    required this.imagePath,
  }) : super(key: key);

  @override
  State<BidCard> createState() => _BidCardState();
}

class _BidCardState extends State<BidCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => ProductScreen(productId: widget.product.id)));
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom:
                  BorderSide(color: Colors.black.withOpacity(0.3), width: 1),
              top: BorderSide(color: Colors.black.withOpacity(0.3), width: 1),
              left: BorderSide(color: Colors.black.withOpacity(0.3), width: 1),
              right:
                  BorderSide(color: Colors.black.withOpacity(0.3), width: 1)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
                height: 150,
                width: double.infinity,
                fit: BoxFit.contain,
                widget.imagePath),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: ReadMoreText(widget.name,
                  trimLines: 1,
                  colorClickableText: Colors.orange,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: ReadMoreText(
                  widget.description,
                  trimLines: 1,
                  trimMode: TrimMode.Line,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(Utils.formatCurrency(widget.lastPrice),
                  style: const TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ReadMoreText(
                'Owner : ${widget.owner}',
                trimLines: 1,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: ReadMoreText(
                'Bid : ${widget.lastBidUser}',
                trimLines: 1,
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
              ),
            ),
            const SizedBox(height: 10),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RaisedButton.icon(
                    elevation: 0,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Color.fromARGB(255, 255, 255, 255),
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.brightness_1,
                      color:
                          widget.state == "Active" ? Colors.green : Colors.red,
                      size: 10,
                    ),
                    label: Text(
                      widget.state,
                      style: TextStyle(fontSize: 10),
                    ),
                    onPressed: () {},
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductScreen(
                                    productId: widget.product.id,
                                  )));
                    },
                    child: Container(
                      width: 55,
                      child: FlatButton(
                        height: 15,
                        padding: EdgeInsets.all(0),
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: widget.state == "Active"
                                    ? Colors.green
                                    : Colors.red,
                                width: 1,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(1)),
                        child: Text(
                            widget.state == "Active" ? 'Place bid' : 'Sold out',
                            style:
                                TextStyle(color: Colors.black, fontSize: 10)),
                        onPressed: () {
                          MaterialPageRoute(
                              builder: ((context) => ProductScreen(
                                    productId: widget.product.id,
                                  )));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
