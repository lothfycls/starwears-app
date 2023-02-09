import 'package:flutter/material.dart';

class ListingCard extends StatelessWidget {
  const ListingCard({
    Key? key,
    required this.title,
    required this.ownerName,
    required this.description,
    required this.auctionEnd,
    required this.imagePath,
  }) : super(key: key);
  final String title;
  final String description;
  final String auctionEnd;
  final String ownerName;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 300,
      width: 200,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                height: 150,
                child: Image.network(fit: BoxFit.cover, imagePath)),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              child: Text(auctionEnd),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                description,
                style: TextStyle(fontSize: 11),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text("Owner: $ownerName"),
            ),
            const Spacer(),
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
                child: const Text('Place Bid'),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
