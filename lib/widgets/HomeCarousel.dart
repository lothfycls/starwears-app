import 'dart:ui';

import 'package:flutter/material.dart';

class HomeCarousel extends StatefulWidget {
  @override
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Container(
            height: 300,
            // color: Color.fromARGB(107, 255, 255, 255),
            child: PageView.builder(
              
              itemCount: 3,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                // return Image.network(
                //   'https://picsum.photos/id/${index + 1}/300/300',
                //   fit: BoxFit.cover,
                // );
                return ShaderMask(
                  blendMode: BlendMode.srcOver,
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Color.fromARGB(150, 255, 255, 255), Color.fromARGB(106, 255, 255, 255)],
                      stops: [0.0, 1.0],
                    ).createShader(bounds);
                  },
                  child: Image.asset(
                    'assets/images/imagecarousel.png',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              height: 50,
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  
                  Container(
                    height: 30,
                    width: 30,
                    margin: EdgeInsets.only(left: 10),
                    padding: EdgeInsets.only(left: 7),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: FractionallySizedBox(
                        heightFactor: 1.0,
                        widthFactor: 1.0,
                        child: Transform.scale(
                          scale: 1,
                          child: Icon(Icons.arrow_back_ios),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintStyle: TextStyle(color: Color(0xffBEBEBE)),
                          alignLabelWithHint: true,
                          hintText: 'Search',
                          border: InputBorder.none,
                          suffixIcon: Icon(
                            Icons.search,
                            color: Color(0xffBEBEBE),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  )
                  // Icon(Icons.search),
                ],
              ),
            ),
          ),
          // Container(height: 300,color: Color.fromARGB(102, 255, 255, 255),),
          Positioned(
            bottom: -20,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(left: 20),

              
              height: 120,
           
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'New Listings',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 200,
                    height: 30,
                    child: Text(
                      textAlign: TextAlign.left,
                      'Some text to describe the new product we listed,',
                      style:
                          TextStyle(fontSize: 13, overflow: TextOverflow.clip),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            // left: 0,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == index
                        ? Color(0xFFB22222)
                        : Colors.black,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
