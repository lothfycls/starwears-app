import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starwears/Screens/LoginScreen.dart';
import 'package:starwears/Screens/connected_account/BidsScreen.dart';
import 'package:starwears/Screens/connected_account/ProfileScreen.dart';
import 'package:starwears/bloc/authentication_bloc.dart';
import 'package:starwears/main.dart';

import '../../services/shared_preferences_service.dart';
import 'PurchasesScreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 40,
        centerTitle: true,
        title: Text(
          'Account',
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
              Icons.logout,
              color: Colors.black,
              size: 22,
            ),
            onPressed: () async {
              BlocProvider.of<AuthenticationBloc>(context).add(InitAuth());
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              SharedPreferencesService sharedPreferencesService =
                  SharedPreferencesService();
              await sharedPreferencesService.removeUser();
              outerNavigator.currentState!.push(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
              // Perform some action when the button is pressed
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => ProfileScreen()),
              );
            },
            child: AccountCard(
              title: "Profile",
              subtitle:
                  "Edit your passsword, Name, Bid preference, Email, Username",
              icon: Icons.person,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => const PurchasesScreen()),
              );
            },
            child: AccountCard(
              title: "Purchases",
              subtitle:
                  "Edit your passsword, Name, Bid preference, Email, Username",
              icon: Icons.list_alt,
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => BidsScreen()),
              );
            },
            child: AccountCard(
              title: "Bids",
              subtitle:
                  "Edit your passsword, Name, Bid preference, Email, Username",
              icon: Icons.gavel,
            ),
          ),
          AccountCard(
              title: "Payments",
              subtitle:
                  "Edit your passsword, Name, Bid preference, Email, Username",
              icon: Icons.credit_card),
          AccountCard(
              title: "Help",
              subtitle:
                  "Edit your passsword, Name, Bid preference, Email, Username",
              icon: Icons.help),
        ],
      ),
    );
  }
}

class AccountCard extends StatelessWidget {
  String title;
  String subtitle;
  IconData icon;
  AccountCard(
      {Key? key,
      required this.title,
      required this.icon,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: Color(0xffF6F6F6),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.red,
              size: 50,
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 5),
                Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 120,
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.left,
                    style: TextStyle(overflow: TextOverflow.clip),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
