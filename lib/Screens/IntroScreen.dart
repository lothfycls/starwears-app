import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:starwears/Screens/HomeScreen.dart';
import 'package:starwears/Screens/SignUpScreen.dart';

class introScreen extends StatefulWidget {
  @override
  _introScreenState createState() => _introScreenState();
}

class _introScreenState extends State<introScreen> {
  int _currentIndex = 0;
  final List<String> _imageUrls = [
    'https://picsum.photos/id/1/800/400',
    'https://picsum.photos/id/0/800/400',
    'https://picsum.photos/id/2/800/400',
    'https://picsum.photos/id/3/800/400',
  ];
  final List<String> _texts = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et ante eget quam faucibus vehicula sed quis leo. Praesent dignissim. 1',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et ante eget quam faucibus vehicula sed quis leo. Praesent dignissim.2',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et ante eget quam faucibus vehicula sed quis leo. Praesent dignissim.3',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam et ante eget quam faucibus vehicula sed quis leo. Praesent dignissim.4'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              height: 450,
              child: PageView.builder(
                itemCount: _imageUrls.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(100),
                        // topRight: Radius.circular(100),
                      ),
                      child: Image.asset(
                          fit: BoxFit.fill, "assets/images/imagecarousel.png"));
                },
              ),
            ),
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Image.asset(
                color: Colors.white,
                'assets/images/logo.png',
                height: 50,
              ),
            ),
          ]),
          Container(
            height: 50,
            child: Center(
              child: DotsIndicator(
                dotsCount: _imageUrls.length,
                position: _currentIndex.toDouble(),
                decorator: DotsDecorator(
                  activeColor: Colors.black,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text(
              _texts[_currentIndex],
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              color: Colors.black,
              textColor: Colors.white,
              child: Text(_currentIndex == 3 ? 'Finish' : 'Next'),
              onPressed: () {
                if (_currentIndex == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                } else {
                  setState(() {
                    _currentIndex = (_currentIndex + 1) % _imageUrls.length;
                  });
                }
                // Handle the button press
              },
            ),
          ),
        ],
      ),
    );
  }
}
