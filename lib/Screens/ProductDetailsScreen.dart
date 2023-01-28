import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:starwears/widgets/BidCard.dart';
import 'package:starwears/widgets/CategoryCard.dart';

import '../widgets/AboutItemCard.dart';
import '../widgets/CelebritiesCard.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
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
                  "Product",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
        title: Text(
          'Details',
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //     width: double.infinity,
            //     height: 250,
            //     child: Image.asset(
            //         fit: BoxFit.cover, 'assets/images/imagecarousel.png')),
            Container(
                width: double.infinity,
                height: 250,
                child: Image.asset(
                    fit: BoxFit.cover, 'assets/images/imagecarousel.png')),

            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.only(left: 10.0, top: 10),
              width: MediaQuery.of(context).size.width - 10,
              child: Text(
                "Black Channel dress worn by beyonce at the25th BET Awards ",
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                overflow: TextOverflow.clip,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Brand",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Condition",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Category",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Quantity",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Department",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Closure",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Handle/Strap Color",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Occassion",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Material",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Bag Color",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Interior Material",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Interior Color",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Style",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Finish",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Auction End",
                        style: TextStyle(color: Color(0xff53565A)),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 60,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Chanel",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Used",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Dress",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "1",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Women",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Zip",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Strapless",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Formal and Casual",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Wool",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Black",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Cotton",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Black",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Classy",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Quilted",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                       Text(
                        "8 days",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
