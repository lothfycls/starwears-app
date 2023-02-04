import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:starwears/bloc/products_bloc.dart';
import 'package:starwears/widgets/CategoryCard.dart';

import '../bloc/category_bloc.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ProductsBloc>(context)
        .add(GetProductsByCategory(categoryId: 2));
  }

  int _value = 0;

  void _onChanged(int value) {
    BlocProvider.of<ProductsBloc>(context)
        .add(GetProductsByCategory(categoryId: BlocProvider.of<CategoryBloc>(context).currentCategories[value].id));
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
            'Categories',
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
                            _value == index
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
                      padding: EdgeInsets.symmetric(horizontal: 10),

                      // itemExtent: 1/2,
                      // physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CategoryCard(
                          expirationDate: state.products[index].auctionEnd,
                          image: state.products[index].images[0],
                          name: state.products[index].name,
                          price: state.products[index].lastPrice.toString(),
                        );
                      },
                    ),
                  );
                } else if(state is ProductsFailed){
                  return Center(
                    child: Text("Error items"),
                  );
                }
                else{
                    return Center(
                    child: Text("Nothing"),
                  );
                }
              },
            ),
          ],
        ));
  }
}
