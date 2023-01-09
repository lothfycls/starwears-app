import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../widgets/HomeCarousel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
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
                onPressed: () {},
              ),
            ),
            SizedBox(
              width: 15,
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
          Container(
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
            return Container(
              height: 340,
              width: 200,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 200,
                        // height: 50,
                        child: Image.asset(
                            fit: BoxFit.fitWidth,
                            'assets/images/imagecarousel.png')),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: Text('Louis Vuitton Suit',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text('Worn at balon d’or'),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("\$12,600",
                          style: TextStyle(color: Colors.orange)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text('Owner: Benzema'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text('Bid: User9099'),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        RaisedButton.icon(
                          elevation: 0,
                          color: Color.fromARGB(255, 255, 255, 255),
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            Icons.brightness_1,
                            color: Colors.green,
                            size: 10,
                          ),
                          label: Text(
                            'Active',
                            style: TextStyle(fontSize: 10),
                          ),
                          onPressed: () {},
                        ),
                        SizedBox(width: 5),
                        FlatButton(
                          height: 15,
                          padding: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: Colors.green,
                                  width: 1,
                                  style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(1)),
                          child: Text('Place bid',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10)),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
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
                        "Suits",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      )
                    ]),
              );
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
          Container(
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
            return Container(
              height: 300,
              width: 200,
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: 200,
                        // height: 50,
                        child: Image.asset(
                            fit: BoxFit.fitWidth,
                            'assets/images/imagecarousel.png')),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: Text('5th December'),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Balenciaga Shoes',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        'Worn at balon d’or',
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 7),
                      height: 20,
                      width: double.infinity,
                      child: FlatButton(
                        onPressed: () {
                          // Code to execute when button is pressed
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Text('Place Bid'),
                      ),
                    )
                  ],
                ),
              ),
            );
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
                        "Benzema",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      )
                    ]),
              );
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
                        "Louis Vuitton",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      )
                    ]),
              );
            }),
      ),
    ]);
  }
}
