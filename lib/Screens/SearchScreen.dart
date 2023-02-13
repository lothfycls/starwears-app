import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:starwears/widgets/BidCard.dart';

import 'Notifications.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
   List<String> items=['Apparels','Shoes','Bags','Accessories','Collectibles'];

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
              margin: EdgeInsets.only(left: 50, top: 20, bottom: 10, right: 8),
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
              padding: EdgeInsets.only(right: 15,top: 7),
              icon: Icon(
                Icons.notifications_outlined,
                color: Colors.black,
                size: 27,
              ),
              onPressed: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const NotificationsScreen()));
                // Perform some action when the button is pressed
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 40,
                margin: const EdgeInsets.only(left: 20),
                child: ListView.builder(
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
              
              SizedBox(height: 150,),
              Icon(Icons.search_sharp,size: 150,),
              Text("What are you looking for?",style: TextStyle(fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Text("Type your query in the search bar"),
        
             
            ],
          ),
        ));
  }
}
