import 'package:flutter/material.dart';
import 'package:starwears/models/product.dart';

class BrandCard extends StatelessWidget {
  final Product product;
  const BrandCard({
    Key? key,required this.product
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
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      fit: BoxFit.cover, product.images[0]),
                )),
            Container(
              height: 60,
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              width: MediaQuery.of(context).size.width - 10,
              child: Text(
                product.name,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                overflow: TextOverflow.clip,
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text('Owner: Beyonce'),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 10),
              child: Row(
                children: [
                  Text(
                    "\$${product.lastPrice}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      // color: Color(0xffEB9B00),
                    ),
                  ),
                  SizedBox(width: 70),
                  Text(
                    "17  Bids",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      // color: Color(0xffEB9B00),
                    ),
                  ),
                  SizedBox(width: 18),
                  Text(
                    product.auctionEnd,
                    style:const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      // color: Color(0xffEB9B00),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
