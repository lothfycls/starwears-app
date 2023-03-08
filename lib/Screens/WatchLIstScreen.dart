import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/bloc/products_bloc.dart';
import 'package:starwears/bloc/watchlist_bloc.dart';

import '../bloc/authentication_bloc.dart';
import '../utils/utils.dart';
import 'LoginScreen.dart';
import 'Notifications.dart';
import 'ProductScreen.dart';

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
    watchlistBloc = BlocProvider.of<WatchlistBloc>(context);
    BlocProvider.of<WatchlistBloc>(context).add(GetActiveWatchList());
  }

  void _onChanged(bool value) {
    if (value == true) {
      BlocProvider.of<WatchlistBloc>(context).add(GetEndedWatchList());
    } else {
      BlocProvider.of<WatchlistBloc>(context).add(GetActiveWatchList());
    }
    setState(() {
      _value = value;
    });
  }

  late WatchlistBloc watchlistBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 40,
          centerTitle: true,
          title: const Text(
            'Watchlist',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 17.0,
            ),
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 15),
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
            BlocBuilder<WatchlistBloc, WatchlistState>(
              builder: (context, state) {
                if (state is WatchListReady) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            if (!_value) {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ProductScreen(
                                              productId:
                                                  state.products[index].id)))
                                  .then((value) {
                                watchlistBloc.add(GetActiveWatchList());
                              });
                            }
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
                                    borderRadius: BorderRadius.circular(15),
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            state.products[index].images[0]),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 60,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Flexible(
                                          child: Text(
                                            state.products[index].description,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.clip,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Flexible(
                                            flex: 3,
                                            child: Text(
                                              "${Utils.formatCurrency(state.products[index].lastPrice)}",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 23,
                                                color: Color(0xffEB9B00),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 40),
                                          Flexible(
                                            child: Text("Bids: " +
                                                state.products[index].bidsCount
                                                    .toString()),
                                          ),
                                          const SizedBox(width: 15),
                                          Flexible(
                                            child: Text(state
                                                .products[index].auctionEnd),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
                    child: Text("No watchlist items"),
                  );
                }
              },
            )
          ],
        ));
  }
}
