import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:starwears/Screens/CancelBidScreen.dart';
import 'package:starwears/Screens/PlaceBidScreen.dart';
import 'package:starwears/Screens/ProductDetailsScreen.dart';
import 'package:starwears/widgets/BidCard.dart';
import 'package:starwears/widgets/CategoryCard.dart';
import 'package:http/http.dart' as http;
import '../bloc/products_bloc.dart';
import '../models/product.dart';
import '../widgets/AboutItemCard.dart';
import '../widgets/CelebritiesCard.dart';

class WonBidScreen extends StatefulWidget {
  final Product product;
  const WonBidScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<WonBidScreen> createState() => _WonBidScreenState();
}

class _WonBidScreenState extends State<WonBidScreen> {
  int _currentIndex = 0;
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
                  "Bids",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        title: Text(
          'Won Bid',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 17.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 15),
            icon: Icon(
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Congratulations!!!",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 250,
              child: PageView.builder(
                itemCount: widget.product.images.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Image.network(
                      fit: BoxFit.cover, widget.product.images[index]);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              //  color: Colors.black.withOpacity(0.5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.product.images.length,
                  (index) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          _currentIndex == index ? Colors.black : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              width: MediaQuery.of(context).size.width - 10,
              child: Text(
                widget.product.name,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                overflow: TextOverflow.clip,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                "\$${widget.product.lastPrice}",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text(
                    "90  Bids",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    "0d 0h",
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                "Winner: You",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Divider(
                thickness: 2,
                color: Colors.grey,
              ),
            ),
            SizedBox(
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
                child: Text(
                  'Payment',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  // 
                  // );
                },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CancelBidScreen()),
                      );
                    },
                    child: Text(
                      "Cancel",
                      style:
                          TextStyle(color: Color.fromARGB(255, 201, 198, 198)),
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => ProductDetailsScreen(
                              product: widget.product,
                            )),
                  );
                },
                child: AboutItemCard(
                  product: widget.product,
                )),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                "Item description",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              // padding: const EdgeInsets.only(left: 10.0, top: 10),
              width: MediaQuery.of(context).size.width - 10,
              child: Text(
                widget.product.description,
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Text(
                "Related Products",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
              if (state is ProductsReady) {
                return Container(
                  height: 340,
                  // width: 300,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        state.products.length > 4 ? 4 : state.products.length,
                    itemBuilder: (context, index) {
                      return BidCard(
                        product: state.products[index],
                        description: state.products[index].description,
                        imagePath: state.products[index].images[0],
                        lastBidUser: state.products[index].lastBidder,
                        lastPrice: state.products[index].lastPrice,
                        name: state.products[index].name,
                        owner: state.products[index].ownerName,
                        state: state.products[index].state,
                      );
                    },
                  ),
                );
              } else {
                return Center(child: Text("No trending"));
              }
            }),
          ],
        ),
      ),
    );
  }

  
}
