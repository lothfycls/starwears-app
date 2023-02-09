import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/widgets/BidCard.dart';
import 'package:starwears/widgets/CategoryCard.dart';

import '../bloc/products_bloc.dart';
import '../widgets/CelebritiesCard.dart';
import 'ProductScreen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
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
                    "Home",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          title: Text(
            'Products',
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
        body: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            if (state is ProductsReady) {
              return GridView.builder(
                // physics: NeverScrollableScrollPhysics(),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      (MediaQuery.of(context).size.width / 220).truncate(),
                  //  childAspectRatio: MediaQuery.of(context).size.width /
                  //             (MediaQuery.of(context).size.height-250),
                  childAspectRatio: 0.6,

                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                // itemExtent: 1/2,
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: state.products.length,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                      onTap: (() {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ProductScreen(productId :state.products[index].id)),
                        );
                      }),
                      child: BidCard(
                        product: state.products[index],
                        description: state.products[index].description,
                        imagePath: state.products[index].images[0],
                        lastBidUser: state.products[index].lastBidder,
                        lastPrice: state.products[index].lastPrice,
                        name: state.products[index].name,
                        owner: state.products[index].ownerName,
                        state: state.products[index].state,
                      ));
                },
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //   childAspectRatio: 0.55,
                //   crossAxisCount: 2,
                // ),
              );
            } else {
              return Center(
                child: Text("No products"),
              );
            }
          },
        ));
  }
}
