import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:starwears/Screens/BrandScreen.dart';
import 'package:starwears/Screens/CategoriesScreen.dart';
import 'package:starwears/Screens/CelebritiesScreen.dart';
import 'package:starwears/Screens/ListingScreen.dart';
import 'package:starwears/Screens/ProductScreen.dart';
import 'package:starwears/Screens/ProductsScreen.dart';

import '../Providers/IndexProvider.dart';
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
  Widget build(BuildContext context) {
    IndexProvider indexProvider = Provider.of<IndexProvider>(context);

    return ListView(padding: EdgeInsets.only(bottom: 20), children: [
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
            onTap:(){
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
        height: 130,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (() {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => CategoriesScreen()),
                  );
                }),
                child: ImageCard(title:"suits"));
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
            onTap: (){
              Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => ListingScreen()),
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
        height: 300,
        // width: 300,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 15),
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) {
            return  ListingCard();
          },
        ),
      ),
     
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          "Featured Celebrities",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      Container(
        height: 130,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),

            // padding: EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                   Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => CelebretiesScreen()),
                  );
                },
                child: ImageCard(title:"Benzima"));
            }),
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Text(
          "Featured Brands",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      Container(
        height: 130,
        child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 15),

            // padding: EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            itemCount: 4,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (() {
                   Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (BuildContext context) => BrandScreen()),
                  );
                }),
                child: ImageCard(title:"Louis Vuitton"));
            }),
      ),
    ]);
  }
}



class ImageCard extends StatelessWidget {
  String title;
   ImageCard({

    Key? key,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: 100,
                // height: 50,
                child: Image.asset(
                    fit: BoxFit.fitWidth,
                    'assets/images/imagecarousel.png')),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 14),
            )
          ]),
    );
  }
}
