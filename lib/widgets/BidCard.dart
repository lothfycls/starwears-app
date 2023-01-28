import 'package:flutter/material.dart';

class BidCard extends StatelessWidget {
  const BidCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 240,
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
                Container(
                  width: 55,
                  child: FlatButton(
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}