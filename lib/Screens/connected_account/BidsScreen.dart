import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/Screens/LoginScreen.dart';
import 'package:starwears/Screens/ProductScreen.dart';
import 'package:starwears/Screens/WonBidScreen.dart';
import 'package:starwears/bloc/authentication_bloc.dart';
import 'package:starwears/widgets/BidCard.dart';
import 'package:starwears/widgets/CategoryCard.dart';

import '../../bloc/products_bloc.dart';

class BidsScreen extends StatefulWidget {
  const BidsScreen({Key? key}) : super(key: key);

  @override
  State<BidsScreen> createState() => _BidsScreenState();
}

class _BidsScreenState extends State<BidsScreen> {
  List<String> items = [
    'Active',
    'Won',
    'Didn’t Win',
  ];

  int _value = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductsBloc>(context).add(GetUserActiveBids());
  }

  void _onChanged(int value) {
    if (value == 1) {
      BlocProvider.of<ProductsBloc>(context).add(GetUserWonBids());
    }
    if (value == 2) {
      BlocProvider.of<ProductsBloc>(context).add(GetUserLostBids());
    }
    if (value == 0) {
      BlocProvider.of<ProductsBloc>(context).add(GetUserActiveBids());
    }
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
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
                          "Account",
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ),
                title: Text(
                  'Bids',
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
              body: Column(
                children: [
                  Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              // width: 100,
                              child: FlatButton(
                                onPressed: () => _onChanged(index),
                                child: Text(items[index]),
                              ),
                            ),
                            _value == index
                                ? Positioned(
                                    bottom: 0,
                                    left: 15,
                                    right: 0,
                                    child: Container(
                                      height: 2.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        );
                      },
                    ),
                  ),
                  BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductsReady) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.products.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ProductScreen(
                                              productId:
                                                  state.products[index].id,
                                            )),
                                  );
                                },
                                child: Card(
                                  color: Color(0xffF6F6F6),
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.rectangle,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: NetworkImage(state
                                                  .products[index].images[0]),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 60,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Text(
                                              state.products[index].description,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.clip,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Row(
                                            children: [
                                              Text(
                                                "\$ ${state.products[index].lastPrice}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 23,
                                                  color: Color(0xffEB9B00),
                                                ),
                                              ),
                                              SizedBox(width: 40),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      "${state.products[index].bidsCount} Bids"),
                                                ],
                                              ),
                                              SizedBox(width: 15),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(state.products[index]
                                                      .auctionEnd),
                                                  //Text("18h"),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: Text("No bids yet"),
                        );
                      }
                    },
                  )
                ],
              ));
        } else {
          return SafeArea(
            child: Center(
              child: Column(children: [
                Text("You have to login in order to see this page"),
                const SizedBox(
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
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => LoginScreen()));
                          //await makePayment(prod.lastPrice.toString());
                        })),
              ]),
            ),
          );
        }
      },
    );
  }
}
