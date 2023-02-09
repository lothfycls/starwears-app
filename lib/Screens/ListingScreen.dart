import 'package:flutter/material.dart';

import '../models/banner.dart' as banner;
import '../widgets/ListingCard.dart';

class ListingScreen extends StatefulWidget {
  const ListingScreen({Key? key, required this.banners}) : super(key: key);
  final List<banner.Banner> banners;
  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
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
            'Upcoming Listings',
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
        body: GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),

          // itemExtent: 1/2,
          // physics: NeverScrollableScrollPhysics(),

          scrollDirection: Axis.vertical,
          itemCount: widget.banners.length,
          itemBuilder: (BuildContext context, int index) {
            return ListingCard(
              auctionEnd: widget.banners[index].auctionEnd,
              ownerName: widget.banners[index].ownerName,
              title: widget.banners[index].title,
              description: widget.banners[index].description,
              imagePath: widget.banners[index].image[0],
            );
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                (MediaQuery.of(context).size.width / 220).truncate(),
            childAspectRatio: 0.6,
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
          ),

          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //   childAspectRatio: 0.65,
          //   crossAxisCount: 2,
          // ),
        ));
  }
}
