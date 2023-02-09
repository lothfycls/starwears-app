import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starwears/Screens/BrandScreen.dart';
import 'package:starwears/Screens/CategoriesScreen.dart';
import 'package:starwears/Screens/CelebritiesScreen.dart';
import 'package:starwears/Screens/ListingScreen.dart';
import 'package:starwears/Screens/PlaceBidScreen.dart';
import 'package:starwears/Screens/ProductsScreen.dart';
import 'package:starwears/bloc/newlistings_bloc.dart';
import 'package:starwears/bloc/products_bloc.dart';

import '../Providers/IndexProvider.dart';
import '../bloc/banner_bloc.dart';
import '../bloc/brand_bloc.dart';
import '../bloc/category_bloc.dart';
import '../bloc/celebrity_bloc.dart';
import '../widgets/BidCard.dart';
import '../widgets/HomeCarousel.dart';
import '../widgets/ListingCard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<BrandBloc>(context).add(GetBrands());
    BlocProvider.of<BannerBloc>(context).add(GetBanner());
    BlocProvider.of<CelebrityBloc>(context).add(GetCelebrities());
    BlocProvider.of<CategoryBloc>(context).add(GetCategories());
    BlocProvider.of<ProductsBloc>(context).add(GetTrendingProducts());
    BlocProvider.of<NewlistingsBloc>(context).add(GetListings());
  }

  @override
  Widget build(BuildContext context) {
    IndexProvider indexProvider = Provider.of<IndexProvider>(context);

    return SafeArea(
      child: ListView(padding: const EdgeInsets.only(bottom: 20), children: [
        HomeCarousel(),
        RowTabs(indexProvider: indexProvider),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Trending Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => ProductsScreen()),
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_right_alt,
                        size: 30,
                      ),
                      onPressed: () {
                        // Do something when the button is pressed
                      },
                    ),
                    Text("See All", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ),
          ],
        ),
        BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
          if (state is ProductsReady) {
            return Container(
              height: 340,
              // width: 300,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.horizontal,
                itemCount:
                    state.products.length > 4 ? 4 : state.products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: BidCard(
                      product: state.products[index],
                      description: state.products[index].description,
                      imagePath: state.products[index].images[0],
                      lastBidUser: state.products[index].lastBidder,
                      lastPrice: state.products[index].lastPrice,
                      name: state.products[index].name,
                      owner: state.products[index].ownerName,
                      state: state.products[index].state,
                    ),
                  );
                },
              ),
            );
          } else {
            return Center(child: Text("No trending"));
          }
        }),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            "Products Categories",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            if (state is CategoriesReady) {
              return Container(
                height: 200,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: (() {
                            Navigator.of(context)
                                .push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          CategoriesScreen()),
                                )
                                .then((value) =>
                                    BlocProvider.of<ProductsBloc>(context)
                                        .add(GetTrendingProducts()));
                            ;
                          }),
                          child: ImageCard(
                            title: state.categories[index].name,
                            image:
                                "https://images.unsplash.com/photo-1675241816662-faab5f4c3f88?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1964&q=80",
                          ));
                    }),
              );
            } else {
              return const Center(
                child: Text("no categories"),
              );
            }
          },
        ),
        Stack(
          children: [
            Container(
                height: 140,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                    fit: BoxFit.cover, 'assets/images/imagecarousel.png')),
            Positioned(
              left: 20,
              bottom: 20,
              child: Text(
                'An enticing Offer for users',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              left: 20,
              bottom: 40,
              child: Text(
                'Offers',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Upcoming Listings",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (BuildContext context) => ListingScreen(
                            banners:
                                BlocProvider.of<BannerBloc>(context).banners,
                          )),
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_right_alt,
                        size: 30,
                      ),
                      onPressed: () {
                        // Do something when the button is pressed
                      },
                    ),
                    Text("See All", style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ),
          ],
        ),
        BlocBuilder<BannerBloc, BannerState>(
          builder: (context, state) {
            if (state is BannerReady) {
              return Container(
                height: 320,
                // width: 300,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      state.banners.length > 4 ? 4 : state.banners.length,
                  itemBuilder: (context, index) {
                    return ListingCard(
                      auctionEnd: state.banners[index].auctionEnd,
                      ownerName: state.banners[index].ownerName,
                      title: state.banners[index].title,
                      description: state.banners[index].description,
                      imagePath: state.banners[index].image[0],
                    );
                  },
                ),
              );
            } else if (state is BannerFailed) {
              return const Center(
                child: Text("Error"),
              );
            } else {
              return const Center(
                child: Text("No Upcoming products for now"),
              );
            }
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            "Featured Celebrities",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        BlocBuilder<CelebrityBloc, CelebrityState>(
          builder: (context, state) {
            if (state is CelebritiesReady) {
              return Container(
                height: 150,
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 15),

                    // padding: EdgeInsets.all(10),
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const CelebretiesScreen()),
                            );
                          },
                          child: ImageCard(
                            title: state.celebrities[index].name,
                            image: state.celebrities[index].pictures[0],
                          ));
                    }),
              );
            }
            if (state is CelebritiesFailed) {
              return const Center(
                child: Text("error"),
              );
            } else {
              return const Center(
                child: Text("no celebrtieis"),
              );
            }
          },
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(
            "Featured Brands",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        BlocBuilder<BrandBloc, BrandState>(
          builder: (context, state) {
            if (state is BrandsReady) {
              return Container(
                height: 150,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 15),

                    // padding: EdgeInsets.all(10),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.brands.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                          onTap: (() {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        BrandScreen(
                                          currentBrand: index,
                                        )))
                                .then((value) =>
                                    BlocProvider.of<ProductsBloc>(context)
                                        .add(GetTrendingProducts()));
                          }),
                          child: ImageCard(
                            title: state.brands[index].name,
                            image: state.brands[index].image,
                          ));
                    }),
              );
            }
            if (state is BrandsFailed) {
              return Center(
                child: Text("Brands error"),
              );
            } else {
              return Center(
                child: Text("No brands"),
              );
            }
          },
        ),
      ]),
    );
  }
}

class RowTabs extends StatelessWidget {
  const RowTabs({
    Key? key,
    required this.indexProvider,
  }) : super(key: key);

  final IndexProvider indexProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      child: ListView(
        children: [
          SizedBox(
            width: 20,
          ),
          Container(
            child: RaisedButton(
              child: Text(
                'Active Bids',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {
                indexProvider.setCurrentIndex(3);
              },
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            child: RaisedButton(
              child: Text(
                'Categories',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CategoriesScreen()),
                    )
                    .then((value) => BlocProvider.of<ProductsBloc>(context)
                        .add(GetTrendingProducts()));
                ;
              },
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            child: RaisedButton(
              child: Text(
                'Brands',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                          builder: (BuildContext context) => BrandScreen(
                                currentBrand: 0,
                              )),
                    )
                    .then((value) => BlocProvider.of<ProductsBloc>(context)
                        .add(GetTrendingProducts()));
                ;
              },
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            child: RaisedButton(
              child: Text(
                'Favourites',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {
                indexProvider.setCurrentIndex(0);
              },
            ),
          ),
          SizedBox(
            width: 15,
          ),
          SizedBox(
            child: RaisedButton(
              child: Text(
                'Celebrities',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              onPressed: () {
                Navigator.of(context)
                    .push(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CelebretiesScreen()),
                    )
                    .then((value) => BlocProvider.of<ProductsBloc>(context)
                        .add(GetTrendingProducts()));
                ;
              },
            ),
          ),
        ],
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  String title;
  String image;
  ImageCard({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: Image.network(fit: BoxFit.cover, image)),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        )
      ]),
    );
  }
}
