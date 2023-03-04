import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/Screens/ProductScreen.dart';
import 'package:starwears/widgets/BidCard.dart';

import '../bloc/category_bloc.dart';
import '../bloc/products_bloc.dart';
import '../models/product.dart';
import '../widgets/CategoryCard.dart';
import 'Notifications.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int initCategory = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductsBloc>(context).add(GetProductsByCategory(
        categoryId: BlocProvider.of<CategoryBloc>(context)
            .currentCategories[initCategory]
            .id));
  }

  void _onChanged(int value) {
    BlocProvider.of<ProductsBloc>(context).add(GetProductsByCategory(
        categoryId: BlocProvider.of<CategoryBloc>(context)
            .currentCategories[value]
            .id));
    setState(() {
      initCategory = value;
    });
  }

  List<Product> products = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 50,
          centerTitle: true,
          title: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 40,
            decoration: const BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Container(
              height: 40,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xFFF0F0F0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                onChanged: (val) {
                  BlocProvider.of<ProductsBloc>(context)
                      .add(GetProductsOnSearch(input: val));
                },
                decoration: const InputDecoration(
                  hintStyle: TextStyle(color: Color(0xFFBEBEBE)),
                  alignLabelWithHint: true,
                  hintText: 'Search',
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              padding: const EdgeInsets.only(right: 15, top: 7),
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
                size: 27,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const NotificationsScreen()));
              },
            ),
          ],
        ),
        body: Column(
          children: [
            BlocBuilder<CategoryBloc, CategoryState>(
              builder: (context, state) {
                if (state is CategoriesReady) {
                  print(state.categories.length);
                  return Container(
                    height: 40,
                    margin: const EdgeInsets.only(left: 20),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              // width: 100,
                              child: FlatButton(
                                onPressed: () => _onChanged(index),
                                child: Text(state.categories[index].name),
                              ),
                            ),
                            initCategory == index
                                ? Positioned(
                                    bottom: 0,
                                    left: 15,
                                    right: 0,
                                    child: Container(
                                      height: 2.0,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
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
                    child: Text("No categories yet"),
                  );
                }
              },
            ),
            BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
                if (state is ProductsReady) {
                  print(state.products.length);
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          child: CategoryCard(
                            expirationDate: state.products[index].auctionEnd,
                            image: state.products[index].images[0],
                            name: state.products[index].name,
                            bids: state.products[index].bidsCount,
                            price: state.products[index].lastPrice.toString(),
                          ),
                        );
                      },
                    ),
                  );
                } else if (state is ProductsFailed) {
                  return const Center(
                    child: Text("No available Products"),
                  );
                } else {
                  return const Center(
                    child: Text("No available products"),
                  );
                }
              },
            ),
          ],
        ));
  }
}
