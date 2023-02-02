import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starwears/Screens/BrandScreen.dart';
import 'package:starwears/Screens/CategoriesScreen.dart';
import 'package:starwears/Screens/CelebritiesScreen.dart';
import 'package:starwears/Screens/ListingScreen.dart';
import 'package:starwears/Screens/ProductsScreen.dart';

import '../Providers/IndexProvider.dart';
import '../bloc/banner_bloc.dart';
import '../bloc/brand_bloc.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    IndexProvider indexProvider = Provider.of<IndexProvider>(context);

    return ListView(padding: const EdgeInsets.only(bottom: 20), children: [
      HomeCarousel(),
      Container(
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => CategoriesScreen()),
                  );
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => BrandScreen()),
                  );
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
            Container(
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => CelebretiesScreen()),
                  );
                },
              ),
            ),
          ],
          scrollDirection: Axis.horizontal,
        ),
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
      Container(
        height: 340,
        // width: 300,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15),
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return BidCard();
          },
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          "Products Categories",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      Container(
        height: 200,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: (() {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CategoriesScreen()),
                    );
                  }),
                  child: ImageCard(
                    title: "suits",
                    image:
                        "https://images.unsplash.com/photo-1675241816662-faab5f4c3f88?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1964&q=80",
                  ));
            }),
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
                          banners: BlocProvider.of<BannerBloc>(context).banners,
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
              height: 300,
              // width: 300,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ListingCard(
                    creationDate: state.banners[index].creationDate,
                    title: state.banners[index].title,
                    description: state.banners[index].description,
                    imagePath: state.banners[index].image,
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
              child: Text("No banners"),
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
                  padding: EdgeInsets.symmetric(horizontal: 15),

                  // padding: EdgeInsets.all(10),
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CelebretiesScreen()),
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
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    BrandScreen()),
                          );
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
    ]);
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
            child: Image.network(fit: BoxFit.cover, image)),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        )
      ]),
    );
  }
}
