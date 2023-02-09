import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/bloc/products_bloc.dart';

import '../bloc/authentication_bloc.dart';
import 'LoginScreen.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  bool _value = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductsBloc>(context).add(GetActiveWatchList());
  }

  void _onChanged(bool value) {
    if (value == 1) {
      BlocProvider.of<ProductsBloc>(context).add(GetEndedWatchList());
    } else {
      BlocProvider.of<ProductsBloc>(context).add(GetActiveWatchList());
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
                elevation: 0,
                backgroundColor: Colors.white,
                toolbarHeight: 40,
                centerTitle: true,
                title: Text(
                  'Watchlist',
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
                    margin: const EdgeInsets.only(left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Stack(
                          children: <Widget>[
                            Container(
                              // width: 100,
                              child: FlatButton(
                                onPressed: () => _onChanged(false),
                                child: Text("Active"),
                              ),
                            ),
                            _value == false
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
                        ),
                        Stack(
                          children: <Widget>[
                            Container(
                              child: FlatButton(
                                onPressed: () => _onChanged(true),
                                child: Text("Ended"),
                              ),
                            ),
                            _value == true
                                ? Positioned(
                                    bottom: 0,
                                    left: 0,
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
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<ProductsBloc, ProductsState>(
                    builder: (context, state) {
                      if (state is ProductsReady) {
                        return Expanded(
                          child: ListView.builder(
                            itemCount: state.products.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
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
                                        borderRadius: BorderRadius.circular(15),
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
                                              "\$${state.products[index].lastPrice}",
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
                                                Text(state
                                                    .products[index].bidsCount
                                                    .toString()),
                                                Text("Bids"),
                                              ],
                                            ),
                                            SizedBox(width: 15),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(state.products[index]
                                                    .auctionEnd),
                                                Text("18h"),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else {
                        return Center(
                          child: Text("No watchlist items"),
                        );
                      }
                    },
                  )
                ],
              ));
        } else {
          return SafeArea(
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => LoginScreen()));
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
