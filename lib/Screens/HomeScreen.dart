import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwears/Screens/MainScreen.dart';

import '../Providers/IndexProvider.dart';
import 'connected_account/AccountScreen.dart';
import 'AuctionScreen.dart';
import 'SearchScreen.dart';
import 'SigningScreen.dart';
import 'WatchLIstScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // int _selectedIndex = 0;
  late List<Widget> _children;
  final _page1 = GlobalKey<NavigatorState>();
  late List<GlobalKey<NavigatorState>> navigators;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigators = List.generate(5, (index) => GlobalKey<NavigatorState>());
    _children = [
      Navigator(
          key: navigators[0],
          onGenerateRoute: (route) =>
              MaterialPageRoute(builder: (context) => WatchListScreen())),
      Navigator(
          key: navigators[1],
          onGenerateRoute: (route) =>
              MaterialPageRoute(builder: (context) => SearchScreen())),
      Navigator(
          key: navigators[2],
          onGenerateRoute: (route) =>
              MaterialPageRoute(builder: (context) => MainScreen())),
      Navigator(
          key: navigators[3],
          onGenerateRoute: (route) =>
              MaterialPageRoute(builder: (context) => AuctionScreen())),
      Navigator(
          key: navigators[4],
          onGenerateRoute: (route) =>
              MaterialPageRoute(builder: (context) => SigningScreen()))
    ];
  }

  void _onItemTapped(int index, IndexProvider IP) {
    IP.setCurrentIndex(index);
  }

  @override
  Widget build(BuildContext context) {
    IndexProvider indexProvider = Provider.of<IndexProvider>(context);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: GestureDetector(
          onTap: () {
            _onItemTapped(2, indexProvider);
          },
          child: Container(
            height: 50,
            width: 50,
            child: Image.asset(
                color:
                    indexProvider.currentIndex == 2 ? Colors.red : Colors.black,
                "assets/images/logo.png"),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterDocked,
        body: _children[indexProvider.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          iconSize: 35,
          unselectedItemColor: Colors.black,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              // icon:  Image.asset("assets/images/wachlist.png", color: Colors.black),
              label: '',
            ),
            BottomNavigationBarItem(
              // icon: Image.asset("assets/images/search.png", color: Colors.black),
              icon: Icon(Icons.search_outlined),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Container(height: 10),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.gavel),
              // icon:  Image.asset("assets/images/auction.png", color: Colors.black),
              label: '',
            ),
            BottomNavigationBarItem(
              // icon:  Image.asset("assets/images/profile.png", color: Colors.black),
              icon: Icon(Icons.person),
              label: '',
            ),
          ],
          currentIndex: indexProvider.currentIndex,
          onTap: (index) {
            _onItemTapped(index, indexProvider);
          },
        ),
      ),
    );
  }
}
