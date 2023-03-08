import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/widgets/BidCard.dart';

import '../bloc/authentication_bloc.dart';
import '../bloc/products_bloc.dart';
import '../main.dart';
import 'LoginScreen.dart';
import 'Notifications.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({Key? key}) : super(key: key);

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  List<String> items = ['Active', 'My bids', 'Ended'];
  int _value = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductsBloc>(context).add(GetActiveProducts());
  }

  void _onChanged(int value) {
    if (value == 0) {
      BlocProvider.of<ProductsBloc>(context).add(GetActiveProducts());
    } else if (value == 1) {
      BlocProvider.of<ProductsBloc>(context).add(GetUserBidProducts());
    } else if (value == 2) {
      BlocProvider.of<ProductsBloc>(context).add(GetEndedProducts());
    }
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              padding: EdgeInsets.only(right: 15),
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
                size: 25,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const NotificationsScreen()));
                // Perform some action when the button is pressed
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 40,
              margin: EdgeInsets.only(left: 10, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
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
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsReady) {
                  return Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 0),
                      itemCount: state.products
                          .length, // number of items in your data source
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (MediaQuery.of(context).size.width / 220)
                                .truncate(),
                        childAspectRatio: 0.55,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                      ),

                      itemBuilder: (BuildContext context, int index) {
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
                } else if (state is UserNotAuthenticated) {
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
                        outerNavigator.currentState!.push(MaterialPageRoute(
                            builder: (_) => const LoginScreen()));
                      },
                    ).show();
                  });
                  return Text("No current bids yet");
                } else if (state is UploadState) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                } else {
                  return const Center(
                    child: Text("No products yet"),
                  );
                }
              },
            )
          ],
        ));
  }
}
