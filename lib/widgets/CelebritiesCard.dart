import 'package:flutter/material.dart';

class CelebritiesCard extends StatelessWidget {
  const CelebritiesCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 233, 230, 230),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      // height: 350,
      width: 300,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                width: double.infinity,
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                      fit: BoxFit.cover, 'assets/images/imagecarousel.png'),
                )),
            Container(
              // height: 60,
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              width: MediaQuery.of(context).size.width - 10,
              child: Text(
                "Karem Benzema",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                overflow: TextOverflow.clip,
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('Profession: Footballer'),
            ),
             SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0,bottom: 10),
              child: Row(
                children: [
                  Text(
                    "22 Items",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      // color: Color(0xffEB9B00),
                    ),
                  ),
                  SizedBox(width: 70),
                  Text("2 Active  Bids",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      // color: Color(0xffEB9B00),
                    ),),
                 
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
