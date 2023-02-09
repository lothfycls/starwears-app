import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/Screens/ProductScreen.dart';
import 'package:starwears/bloc/products_bloc.dart';
import 'package:starwears/widgets/BidCard.dart';
import 'package:starwears/widgets/CategoryCard.dart';

import '../bloc/brand_bloc.dart';
import '../widgets/BrandCard.dart';

class BrandScreen extends StatefulWidget {
  const BrandScreen({Key? key, required this.currentBrand}) : super(key: key);
  final int currentBrand;
  @override
  State<BrandScreen> createState() => _BrandScreenState();
}

class _BrandScreenState extends State<BrandScreen> {
  late int _value;
  @override
  void initState() {
    // TODO: implement initState
    BlocProvider.of<ProductsBloc>(context)
        .add(GetBrandProducts(brandId: widget.currentBrand + 1));
    _value = widget.currentBrand;
    super.initState();
  }

  void _onChanged(int value) {
    BlocProvider.of<ProductsBloc>(context)
        .add(GetBrandProducts(brandId: value + 1));
    setState(() {
      _value = value;
    });
  }

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
            'Brands',
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
            BlocBuilder<BrandBloc, BrandState>(
              builder: (context, state) {
                if (state is BrandsReady) {
                  return Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.brands.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              // width: 100,
                              child: FlatButton(
                                onPressed: () => _onChanged(index),
                                child: Text(state.brands[index].name),
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
                  );
                } else {
                  return const Center(
                    child: Text("No brands"),
                  );
                }
              },
            ),
            Expanded(
              child: BlocBuilder<ProductsBloc, ProductsState>(
                builder: (context, state) {
                  print(state);
                  if (state is ProductsReady) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),

                      // itemExtent: 1/2,
                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => ProductScreen(
                                        productId: state.products[index].id)));
                          },
                          child: BrandCard(
                            product: state.products[index],
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("no products"),
                    );
                  }
                },
              ),
            ),
          ],
        ));
  }
}
