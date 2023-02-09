import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:starwears/Screens/WonBidScreen.dart';
import 'package:starwears/widgets/BidCard.dart';
import 'package:starwears/widgets/CategoryCard.dart';

class PurchasesScreen extends StatefulWidget {
  const PurchasesScreen({Key? key}) : super(key: key);

  @override
  State<PurchasesScreen> createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
 

  

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
                    "Account",
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          title: Text(
            'Orders',
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
        body: Column(
          children: [
            SizedBox(height: 10,),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: (){
                  //      Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (BuildContext context) => WonBidScreen()),
                  // );
                    },
                    child: Card(
                      color: Color(0xffF6F6F6),
                      margin: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/imagecarousel.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 60,
                                width: MediaQuery.of(context).size.width / 2,
                                child: Text(
                                  "Black Channel dress worn by beyonce at the25th BET Awards ",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 15, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    "\$12,600",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23,
                                      color: Color(0xffEB9B00),
                                    ),
                                  ),
                                  SizedBox(width: 40),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("17"),
                                      Text("Bids"),
                                    ],
                                  ),
                                  SizedBox(width: 15),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("5d"),
                                      Text("18h"),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ));
  }
}
