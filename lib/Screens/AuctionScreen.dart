import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:starwears/widgets/BidCard.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({Key? key}) : super(key: key);

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  List<String> items = ['Active', 'My bids', 'Ended'];
  int _value = 0;

  void _onChanged(int value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          toolbarHeight: 50,
          centerTitle: true,
          title: Container(
              margin: EdgeInsets.only(left: 50, top: 10, bottom: 10, right: 8),
              // width: 200,
              height: 30,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1.0),
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  // contentPadding: EdgeInsets.only(top: 0.1),
                  hintStyle: TextStyle(color: Color(0xffBEBEBE), fontSize: 15),
                  alignLabelWithHint: true,
                  hintText: 'Search',
                  border: InputBorder.none,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Color(0xffBEBEBE),
                  ),
                ),
              )),
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
            Container(
              height: 40,
              // width: 200,
              margin: EdgeInsets.only(left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //  SizedBox(
                  //     width: 60,
                  //   ),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Stack(
                          children: <Widget>[
                            Container(
                              // width: 100,
                              child: FlatButton(
                                onPressed: () => _onChanged(index),
                                child: Text(items[index]),
                              ),
                            ),
                            _value == index
                                ? Positioned(
                                    bottom: 0,
                                    left: 15,
                                    right: 0,
                                    child: Container(
                                      height: 2.0,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                : Container()
                          ],
                        );
                      },
                    ),
                  ),
                  ImageIcon(
                    AssetImage("assets/images/filter.png"),
                    size: 20,
                  ),
                  SizedBox(
                    width: 15,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                itemCount: 6, // number of items in your data source
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      (MediaQuery.of(context).size.width / 220).truncate(),
                  // childAspectRatio: MediaQuery.of(context).size.width /
                  //     (MediaQuery.of(context).size.height-250),
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                ),
                // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisSpacing: 5,
                //   mainAxisSpacing: 10,
                //   childAspectRatio: 0.57,
                //   crossAxisCount: 2, // number of elements in each row
                // ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(height: 130, child: BidCard());
                },
              ),
            )
          ],
        ));
  }
}
