import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:starwears/Screens/LoginScreen.dart';
import 'package:starwears/Screens/OrderScreen.dart';
import 'package:starwears/Screens/PlaceBidScreen.dart';
import 'package:starwears/Screens/ProductDetailsScreen.dart';
import 'package:starwears/bloc/singleproduct_bloc.dart';
import 'package:starwears/models/product.dart';
import 'package:starwears/utils/utils.dart';
import 'package:starwears/widgets/BidCard.dart';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';
import '../bloc/products_bloc.dart';
import '../bloc/relationship_bloc.dart';
import '../bloc/watchlist_bloc.dart';
import '../main.dart';
import '../widgets/AboutItemCard.dart';

class ProductScreen extends StatefulWidget {
  final int productId;
  const ProductScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SingleproductBloc>(context)
        .add(GetSingleProduct(productId: widget.productId));
    BlocProvider.of<RelationshipBloc>(context)
        .add(GetRelationShip(productId: widget.productId));
    BlocProvider.of<WatchlistBloc>(context)
        .add(CheckExist(productId: widget.productId));
    relationshipBloc = BlocProvider.of<RelationshipBloc>(context);
  }

  late RelationshipBloc relationshipBloc;
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
                    "Products",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          title: Text(
            'Product',
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
        body: BlocBuilder<SingleproductBloc, SingleproductState>(
          builder: (context, state) {
            if (state is SingleProductReady) {
              Product prod = state.product;
              return SingleChildScrollView(
                padding: EdgeInsets.only(bottom: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<RelationshipBloc, RelationshipState>(
                      builder: (context, state) {
                        if (state is OutbiddedState) {
                          return OutbidedCard(
                              productId: widget.productId,
                              maxBid: state.relationship.bidAmount,
                              timeLeft: prod.auctionEnd);
                        } else if (state is WonState) {
                          return Padding(
                            padding: const EdgeInsets.all(20),
                            child: Center(
                                child: const Text(
                              "Congratulations!",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            )),
                          );
                        } else {
                          return SizedBox();
                        }
                      },
                    ),
                    Container(
                      width: double.infinity,
                      height: 350,
                      child: PageView.builder(
                        itemCount: state.product.images.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Stack(
                            children: <Widget>[
                              const Center(
                                  child: CircularProgressIndicator(
                                color: Colors.black,
                              )),
                              Center(
                                child: FadeInImage.memoryNetwork(
                                  fit: BoxFit.cover,
                                  height: 350,
                                  width: 200,
                                  imageErrorBuilder:
                                      ((context, error, stackTrace) =>
                                          const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.black,
                                            ),
                                          )),
                                  placeholder: kTransparentImage,
                                  image: state.product.images[index],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      //  color: Colors.black.withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          state.product.images.length,
                          (index) => Container(
                            margin: EdgeInsets.symmetric(horizontal: 4),
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentIndex == index
                                  ? Colors.black
                                  : Colors.grey,
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
                        state.product.name,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        Utils.formatCurrency(state.product.lastPrice),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
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
                            "${state.product.bidsCount}  Bids",
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            state.product.auctionEnd,
                            style: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Text(
                        "Last Bid : ${state.product.lastBidder}",
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 30),
                      child: Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<RelationshipBloc, RelationshipState>(
                      builder: (context, state) {
                        if (state is NeverState ||
                            state is RelationshipFailed) {
                          return prod.state == 'Active'
                              ? Container(
                                  height: 45,
                                  width: double.infinity,
                                  margin: EdgeInsets.symmetric(horizontal: 30),
                                  child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0)),
                                      color: Colors.black,
                                      child: Text(
                                        'Submit Bid',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        if (state is NeverState) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      PlaceBidScreen(
                                                          productId: prod.id,
                                                          date: prod.auctionEnd,
                                                          maxBid: state
                                                              .relationship
                                                              .bidAmount)));
                                        } else if (state
                                            is RelationshipFailed) {
                                          AwesomeDialog(
                                            context: context,
                                            dialogType: DialogType.warning,
                                            animType: AnimType.rightSlide,
                                            btnOkColor: Colors.black,
                                            title: 'Sign in Required',
                                            desc:
                                                'This action required to Sign in',
                                            btnCancelOnPress: () {},
                                            btnOkOnPress: () {
                                              outerNavigator.currentState!.push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        const LoginScreen()),
                                              );
                                            },
                                          ).show();
                                        }
                                      }))
                              : const SizedBox();
                        } else if (state is WonState) {
                          return Container(
                            height: 45,
                            width: double.infinity,
                            margin: const EdgeInsets.symmetric(horizontal: 30),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50.0)),
                              color: Colors.black,
                              child: Text(
                                'Place order',
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => OrderScreen(
                                                productId: prod.id,
                                                ownerId: prod.ownerId,
                                                shippingCost: 25,
                                                total: prod.lastPrice)))
                                    .then((value) {
                                  if (value) {
                                    relationshipBloc.add(GetRelationShip(
                                        productId: widget.productId));
                                  }
                                });
                              },
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<WatchlistBloc, WatchlistState>(
                        builder: (context, state) {
                      if (state is WatchListAbsent) {
                        return GestureDetector(
                            onTap: () {
                              BlocProvider.of<WatchlistBloc>(context)
                                  .add(AddWatchList(product: prod));
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              width: double.infinity,
                              height: 45,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.black)),
                              child: Center(
                                child: Text(
                                  "Add to Watchlist",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ));
                      } else {
                        return GestureDetector(
                            onTap: () {
                              BlocProvider.of<WatchlistBloc>(context)
                                  .add(RemoveWatchList(productId: prod.id));
                            },
                            child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                width: double.infinity,
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(color: Colors.black)),
                                child: Center(
                                  child: Text(
                                    "Remove from Watchlist",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )));
                      }
                    }),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    ProductDetailsScreen(
                                      product: state.product,
                                    )),
                          );
                        },
                        child: AboutItemCard(product: state.product)),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        "Item description",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
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
                        state.product.description,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30),
                      child: Text(
                        "Related Products",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<ProductsBloc, ProductsState>(
                        builder: (context, state) {
                      if (state is ProductsReady) {
                        return Container(
                          height: 380,
                          // width: 300,
                          child: ListView.builder(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.products.length,
                            itemBuilder: (context, index) {
                              return BidCard(
                                description: state.products[index].description,
                                imagePath: state.products[index].images[0],
                                lastBidUser: state.products[index].lastBidder,
                                lastPrice: state.products[index].lastPrice,
                                name: state.products[index].name,
                                owner: state.products[index].ownerName,
                                product: state.products[index],
                                state: state.products[index].state,
                              );
                            },
                          ),
                        );
                      } else {
                        return const Center(child: Text("No trending"));
                      }
                    }),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("No product ready"));
            }
          },
        ));
  }


  
      
}

class OutbidedCard extends StatelessWidget {
  final int maxBid;
  final String timeLeft;
  final int productId;
  const OutbidedCard({
    required this.maxBid,
    required this.timeLeft,
    required this.productId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int total = maxBid + 25;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Text(
            "You have been Outbid",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            overflow: TextOverflow.clip,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 236, 233, 233),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            margin: EdgeInsets.symmetric(horizontal: 40),
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 20),
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
                      "€ ${maxBid}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${timeLeft}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "€25",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "€${total}",
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
            height: 10,
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
                'Increase Bid',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PlaceBidScreen(
                            productId: productId,
                            maxBid: maxBid,
                            date: timeLeft)));
                /* do something */
              },
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
