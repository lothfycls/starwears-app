import 'package:flutter/material.dart';

class ListingCard extends StatelessWidget {
  const ListingCard({
    Key? key,
  }) : super(key: key);

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
          );;
  }
}