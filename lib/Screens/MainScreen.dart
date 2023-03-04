import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starwears/Screens/BrandScreen.dart';
import 'package:starwears/Screens/CategoriesScreen.dart';
import 'package:starwears/Screens/CelebritiesScreen.dart';
import 'package:starwears/Screens/ListingScreen.dart';
import 'package:starwears/Screens/ProductsScreen.dart';
import 'package:starwears/bloc/newlistings_bloc.dart';
import 'package:starwears/bloc/products_bloc.dart';
import 'package:starwears/widgets/home_carou.dart';
import 'package:transparent_image/transparent_image.dart';

import '../Providers/IndexProvider.dart';
import '../bloc/banner_bloc.dart';
import '../bloc/brand_bloc.dart';
import '../bloc/category_bloc.dart';
import '../bloc/celebrity_bloc.dart';
import '../widgets/BidCard.dart';
import '../widgets/ListingCard.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BrandBloc>(context).add(GetBrands());
    BlocProvider.of<BannerBloc>(context).add(GetBanner());
    BlocProvider.of<CelebrityBloc>(context).add(GetCelebrities());
    BlocProvider.of<CategoryBloc>(context).add(GetCategories());
    BlocProvider.of<ProductsBloc>(context).add(GetTrendingProducts());
    BlocProvider.of<NewlistingsBloc>(context).add(GetListings());
    _scrollController.addListener(() {
      print(_scrollController.offset);
      if (_scrollController.offset > 100) {
        setState(() {
          showCarousel = false;
        });
      } else {
        setState(() {
          showCarousel = true;
        });
      }
    });
  }

  ScrollController _scrollController = ScrollController();
  bool showCarousel = true;
  @override
  Widget build(BuildContext context) {
    IndexProvider indexProvider = Provider.of<IndexProvider>(context);

    return CustomScrollView(
      slivers: [
        HomeCarou(showCarousel: showCarousel),
        //HomeCarousel(showCarousel: showCarousel),
        SliverToBoxAdapter(
          child: RowTabs(indexProvider: indexProvider),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Trending Products",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                        const Text("See All",
                            style: TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<ProductsBloc, ProductsState>(
              builder: (context, state) {
            if (state is ProductsReady) {
              return Container(
                height: 340,
                // width: 300,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
              return const Center(child: Text("No trending"));
            }
          }),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Text(
              "Products Categories",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<CategoryBloc, CategoryState>(
            builder: (context, state) {
              if (state is CategoriesReady) {
                return SizedBox(
                  height: 170,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: (() {
                              Navigator.of(context)
                                  .push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            CategoriesScreen(
                                                initCategory: index)),
                                  )
                                  .then((value) =>
                                      BlocProvider.of<ProductsBloc>(context)
                                          .add(GetTrendingProducts()));
                              ;
                            }),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: SizedBox(
                                width: 100,
                                child: ImageCard(
                                  title: state.categories[index].name,
                                  image: state.categories[index].image,
                                ),
                              ),
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
        ),
        SliverToBoxAdapter(
          child: Stack(
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
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),
        SliverToBoxAdapter(
          child: Row(
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
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<BannerBloc, BannerState>(
            builder: (context, state) {
              if (state is BannerReady) {
                return SizedBox(
                  height: 320,
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
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Center(
                    child: Text("No Upcoming products for now"),
                  ),
                );
              }
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: const Text(
              "Featured Celebrities",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<CelebrityBloc, CelebrityState>(
            builder: (context, state) {
              if (state is CelebritiesReady) {
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      scrollDirection: Axis.horizontal,
                      itemCount: state.celebrities.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const CelebretiesScreen()),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: SizedBox(
                                width: 100,
                                child: ImageCard(
                                  title: state.celebrities[index].name,
                                  image: state.celebrities[index].pictures[0],
                                ),
                              ),
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
        ),
        SliverToBoxAdapter(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              "Featured Brands",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: BlocBuilder<BrandBloc, BrandState>(
            builder: (context, state) {
              if (state is BrandsReady) {
                return SizedBox(
                  height: 200,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
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
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: SizedBox(
                                width: 100,
                                child: ImageCard(
                                  title: state.brands[index].name,
                                  image: state.brands[index].image,
                                ),
                              ),
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
        ),
      ],
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
    return SizedBox(
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
                    .push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            CategoriesScreen(initCategory: 0)))
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
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            child: RaisedButton(
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
              child: Text(
                'Celebrities',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
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
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: <Widget>[
            const Positioned(
                top: 30,
                left: 30,
                child: CircularProgressIndicator(
                  color: Colors.black,
                )),
            Center(
              child: FadeInImage.memoryNetwork(
                fit: BoxFit.cover,
                height: 100,
                width: 100,
                placeholder: kTransparentImage,
                image: image,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      )
    ]);
  }
}
