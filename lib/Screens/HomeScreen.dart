import 'package:flutter/material.dart';
import 'package:starwears/Screens/MainScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _children = [
    MainScreen(),
    Center(child: Text('Wachlist')),
    Center(child: Text('Search')),
    Center(child: Text('Auction')),
    Center(child: Text('Profile')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Bottom Navigation Bar'),
      // ),
      body: _children[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/home.png", color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:  Image.asset("assets/images/wachlist.png", color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/search.png", color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:  Image.asset("assets/images/auction.png", color: Colors.black),
            label: '',
          ),
          BottomNavigationBarItem(
            icon:  Image.asset("assets/images/profile.png", color: Colors.black),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
