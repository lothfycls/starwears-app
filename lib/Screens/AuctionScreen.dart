import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/widgets/BidCard.dart';

import '../bloc/authentication_bloc.dart';
import '../bloc/products_bloc.dart';
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
    }
    if (value == 1) {
      BlocProvider.of<ProductsBloc>(context).add(GetUserBidProducts());
    } else {
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
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 50,
          centerTitle: true,
          title: Container(
              margin: EdgeInsets.only(left: 50, top: 10, bottom: 10, right: 8),
              // width: 200,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  // contentPadding: EdgeInsets.only(top: 0.1),
                  hintStyle: TextStyle(color: Color(0xffBEBEBE), fontSize: 15),
                  alignLabelWithHint: true,
                  hintText: 'Search',
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color(0xffBEBEBE),
                  ),
                ),
              )),
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
              // width: 200,
              margin: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //  SizedBox(
                  //     width: 60,
                  //   ),
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
                  ImageIcon(
                    AssetImage("assets/images/filter.png"),
                    size: 20,
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                print(state);
                if (state is ProductsReady) {
                  return Expanded(
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      itemCount: state.products
                          .length, // number of items in your data source
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            (MediaQuery.of(context).size.width / 220)
                                .truncate(),
                        // childAspectRatio: MediaQuery.of(context).size.width /
                        //     (MediaQuery.of(context).size.height-250),
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
                } else if (state is ProductsFailed) {
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                    ).show();
                  });

                  return Text("No current bids yet");
                } else {
                  return Center(
                    child: Text("No products yet"),
                  );
                }
              },
            )
          ],
        ));
  }
}
